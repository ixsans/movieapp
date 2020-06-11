part of 'widgets.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Function onTap;

  TicketCard(this.ticket, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                height: 90,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageBaseUrl +
                          'w500' +
                          ticket.movieDetail.posterPath)),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                  width: MediaQuery.of(context).size.width -
                      (defaultMargin * 2) -
                      70 -
                      16 -
                      (16 * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(ticket.movieDetail.title,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 6,
                      ),
                      Text(ticket.movieDetail.getGenreAndLanguage,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: blackTextFont.copyWith(
                              fontSize: 12, color: Color(0xFFADADAD))),
                      SizedBox(
                        height: 6,
                      ),
                      Text(ticket.theater.name,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: blackTextFont.copyWith(
                              fontSize: 12, color: Color(0xFFADADAD))),
                    ],
                  ))
            ],
          ),
        ));
  }
}
