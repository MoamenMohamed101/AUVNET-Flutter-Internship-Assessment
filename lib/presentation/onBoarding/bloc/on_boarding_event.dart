abstract class OnboardingEvent {}

class OnPageChangedEvent extends OnboardingEvent {
  final int newIndex;
  OnPageChangedEvent(this.newIndex);
}

class CompleteOnboardingEvent extends OnboardingEvent {}