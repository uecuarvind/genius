
import '../data/fdr_plan.dart';

abstract class FdrPlanEvent {}

class InitEvent extends FdrPlanEvent {}
class GetPlans extends FdrPlanEvent {}
class SubmitFdr extends FdrPlanEvent {}
class CheckAmount extends FdrPlanEvent {
  Map<String,String> body;
  PlanData data;
  CheckAmount(this.body,this.data);
}