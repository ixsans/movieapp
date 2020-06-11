part of 'pages.dart';

class TopupPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopupPage(this.pageEvent);

  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 20 * 2) / 3;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: defaultMargin),
                    child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(widget.pageEvent);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                  ),
                ),

                // CONTENT
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text('Top Up',
                          style: blackTextFont.copyWith(fontSize: 20)),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: amountController,
                        onChanged: (text) {
                          String temp = '';

                          for (int i = 0; i < text.length; i++) {
                            temp += text.isDigit(i) ? text[i] : '';
                          }

                          setState(() {
                            selectedAmount = int.tryParse(temp) ?? 0;
                          });

                          amountController.text = NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(selectedAmount);

                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: amountController.text.length));
                        },
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: greyTextFont,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 14),
                            child: Text('Choose by Template')),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 14,
                        children: <Widget>[
                          makeMoneyCard(
                            amount: 10000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 20000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 30000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 40000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 60000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 70000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 80000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 90000,
                            width: cardWidth,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            60,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) {
                            return RaisedButton(
                              child: Text('Topup My Wallet',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: selectedAmount > 0
                                          ? Colors.white
                                          : Color(0xFFBEBEBE))),
                              disabledColor: Color(0xFFE4E4E4),
                              color: Color(0xFF3E9D9D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              onPressed: selectedAmount > 0
                                  ? () {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GotoSuccessCheckoutPageEvent(
                                              null,
                                              MovieTransaction(
                                                userId:
                                                    (userState as UserLoaded)
                                                        .user
                                                        .id,
                                                        amount: selectedAmount,
                                                title: "Topup Wallet",
                                                subTitle:
                                                    "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}",
                                                time: DateTime.now(),
                                              )));
                                    }
                                  : null,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
        amount: amount,
        width: width,
        onTap: () {
          setState(() {
            if (selectedAmount != amount) {
              selectedAmount = amount;
            } else {
              selectedAmount = 0;
            }

            amountController.text = NumberFormat.currency(
                    locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                .format(selectedAmount);

            amountController.selection = TextSelection.fromPosition(
                TextPosition(offset: amountController.text.length));
          });
        },
        isSelected: selectedAmount == amount);
  }
}
