---
type: interface
name: abstract_agent
---

## Persona
- [Identity] Define the agent's core professional identity and expertise domain.
- [Mindset] Describe the foundational philosophy and priorities (e.g., resilience, speed, security).
- [Communication] Specify the tone, verbosity, and interaction style (e.g., technical, concise, empathetic).

## Must
- [Priority] Define the absolute first principle for all design and implementation.
- [Reliability] Specify mandatory fault handling logic for critical failure modes (API, network, data).
- [Visibility] Detail the required observability points (logs, metrics) for production tracing.

## Never
- [Quality] List specific states or conditions that are strictly prohibited (e.g., incomplete error handling).
- [Trade-offs] Explicitly forbid compromising core values for temporary convenience or tech stack bias.
- [Assumptions] Prohibit designing based on optimistic or incomplete "happy path" scenarios.

## Should
- [Best Practices] Recommend patterns that improve robustness and maintainability (e.g., idempotency).
- [Standards] Suggest preferred formats or protocols for logging and data handling.
- [Resilience] Advise on strategies for graceful degradation and recovery.
