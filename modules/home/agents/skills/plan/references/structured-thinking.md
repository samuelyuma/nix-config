# Structured Thinking (Sequential Thinking Tool)

If a sequential thinking tool is available (an MCP server for step-by-step reasoning that allows revising earlier steps), use it only when it earns its cost. Each step is a tool call. Do not name the tool in the output.

## Use It When at Least Three Apply

- Many steps depend on each other, and order matters.
- Several competing hypotheses or designs need to be weighed.
- A decision could change after new evidence, so earlier steps may need revising.
- The change crosses modules, services, or data models.
- You cannot see the whole problem yet and need to build the structure gradually.

## Do Not Use It For

A one-file change, a factual question, a task with an obvious order, or wording work.

## How

1. Read the code and sources first. Do not use the tool to guess at facts you can inspect.
2. State the problem and the options in the first step.
3. Keep it to about 5 to 8 steps. Stop as soon as the decision or order is clear.
4. Revise a step when new evidence contradicts it. Say what changed.
5. Keep only the conclusion: the decision, the order, and the open questions. Do not paste the reasoning into the plan, document, or final reply as if it were evidence.

## Remember

The reasoning trail is not a source. A claim still needs code, docs, or a checked source. If the tool is not available, list hypotheses or dependencies directly in the reply and continue.
