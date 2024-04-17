
import '../data/dps_plan.dart';

abstract class DpsPlanEvent {}

class InitEvent extends DpsPlanEvent {}
class GetPlans extends DpsPlanEvent {}
class ApplyDps extends DpsPlanEvent {
  PlanData data;
  ApplyDps(this.data);
}