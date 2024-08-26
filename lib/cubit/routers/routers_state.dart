part of 'routers_cubit.dart';

@immutable
sealed class RoutersState {}

final class RoutersInitial extends RoutersState {}

final class OtherPage extends RoutersState {}
