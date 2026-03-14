# VAS Testing & Validation Protocol

This protocol defines the standard procedure for verifying a new agent definition before deployment.

## 1. Static Validation (Structural Check)

Check the agent file against `file-format.md`:
- [ ] **Frontmatter**: Ensure `type`, `name`, and `extends` (if applicable) are correctly defined.
- [ ] **Keys**: Verify that all rules use either `[Key]` or `**Key**:` format.
- [ ] **Path Resolution**: Confirm all `extends` and `skills` paths are valid and reachable.

## 2. Inheritance Simulation (Mental Merge)

Perform a "dry run" of the inheritance chain:
- [ ] **Chain Resolve**: List all ancestors (Instance -> Class -> Interface).
- [ ] **Key Conflict Check**: Identify which keys are being inherited, which are being accumulated, and which are being replaced by the Instance.
- [ ] **Final Prompt Preview**: Generate the expected final system prompt as it would appear to the LLM.

## 3. Behavioral Verification (Live Test)

Inject a "Challenge Prompt" to the agent and verify the response:
- [ ] **Persona Check**: Does the tone match the merged Persona?
- [ ] **Constraint Check**: Are the `Must` and `Never` rules strictly followed?
- [ ] **Override Check**: If an Instance override exists (e.g., Language change), is it correctly applied over the Class rule?

## 4. Chimera Detection

- [ ] Ensure that the `Class` being extended is logically compatible with the `Instance`'s purpose (e.g., avoid extending Python class for a React instance).
