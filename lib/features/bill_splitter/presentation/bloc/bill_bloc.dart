import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/split_bill.dart';
import 'bill_event.dart';
import 'bill_state.dart';

/// Bill splitter BLoC.
class BillBloc extends Bloc<BillEvent, BillState> {
  /// Creates [BillBloc].
  BillBloc(this._splitBill)
      : super(
          const BillState(
            result: BillSplitResult(tipAmount: 0, totalWithTip: 0, perPerson: 0),
            billAmount: 0,
            tipPercent: 10,
            people: 2,
          ),
        ) {
    on<BillInputsChanged>((BillInputsChanged event, Emitter<BillState> emit) {
      emit(
        state.copyWith(
          billAmount: event.billAmount,
          tipPercent: event.tipPercent,
          people: event.people,
          result: _splitBill(
            billAmount: event.billAmount,
            tipPercent: event.tipPercent,
            people: event.people,
          ),
        ),
      );
    });
  }
  final SplitBill _splitBill;
}
