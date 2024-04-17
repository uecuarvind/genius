import '../data/plans.dart';

abstract class LoanPlanEvent {}

class InitEvent extends LoanPlanEvent {}
class GetPlans extends LoanPlanEvent {}
class CheckAmount extends LoanPlanEvent {
  Map<String,String> body;
  PlanData data;
  CheckAmount(this.body,this.data);
}