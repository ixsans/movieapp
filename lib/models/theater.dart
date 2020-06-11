part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> availableTheaters = [
  Theater('Paris Van Java Park'),
  Theater('Cihampelas Walk'),
  Theater('Bandung Electronic Center'),
  Theater('Cinema XII Bandung'),
];
