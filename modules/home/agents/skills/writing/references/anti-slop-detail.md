# Anti-Slop

Read for explicit humanization or anti-slop cleanup, or when a recurring pattern needs examples. In new text, avoid these patterns. In edits, remove them while preserving meaning and voice. Ordinary writing uses the compact rules in `SKILL.md`.

The patterns come from common signs of AI-written text, based on the Wikipedia guide "Signs of AI writing" and on the humanizer skill. They are written here in plain words and with our own examples.

## Contents

- How to Use This List
- Content Patterns
- Word and Grammar Patterns
- Format and Punctuation Patterns
- Chat Leftovers
- Filler and Hedging

## How to Use This List

- One hit is not proof. Look for **clusters**: several patterns close together. A single "however" or one short sentence is normal writing.
- When you remove a pattern, keep the fact underneath it. If there is no fact underneath, delete the sentence.
- Never replace a vague claim with a specific one unless the specific detail comes from the source text or from the user.
- Paths are relative to the skill root. Language-specific guidance is in `references/languages/english.md` and `references/languages/indonesian.md`.
- Treat examples as contextual signals, not proof of AI authorship or a mechanical blacklist. Explicit voice requests and protected quotations take precedence. Technical meanings stay intact.

## Content Patterns

### 1. Puffed-Up Importance

**Looks like:** "stands as a testament to", "plays a pivotal role", "marks a turning point", "reflects broader trends", "an evolving landscape".
**Why it fails:** It adds weight without adding information.
**Do this:** State what happened, when, and what it affected. Cut the rest.

Before: "The new cache layer marks a pivotal moment in the evolution of the platform's performance story."
After: "The new cache layer cut the dashboard's load time." (Only if the user told you that. Otherwise: "We added a cache layer to the dashboard.")

### 2. Sales Language

**Looks like:** "boasts", "nestled", "vibrant", "breathtaking", "stunning", "must-see", "renowned", "groundbreaking".
**Do this:** Describe the thing neutrally. Docs and explanations are not ads.

### 3. Fake Depth with "-ing" Tails

**Looks like:** a normal sentence followed by a phrase such as "highlighting the importance of...", "ensuring that...", "showcasing how...", "fostering a culture of...".
**Do this:** Delete the tail, or turn it into its own sentence with a real claim.

Before: "The service retries failed requests, ensuring reliability and highlighting the importance of resilience."
After: "The service retries failed requests up to three times." (Only if that is true. Otherwise stop after "requests".)

### 4. Vague Sources

**Looks like:** "experts say", "studies show", "industry reports suggest", "many believe".
**Do this:** Name the source, or cut the claim. Never invent a source.

### 5. Claims of Fame

**Looks like:** a list of outlets or followers used to prove that something matters ("featured in...", "with over 500,000 followers").
**Do this:** Keep one real, relevant mention at most. Cut the rest.

### 6. Formulaic "Challenges and Future" Sections

**Looks like:** "Despite these challenges, the project continues to thrive", "Future outlook", "Looking ahead".
**Do this:** State the real problems and what is planned, in plain sentences, with only facts you have. If you have none, delete the section.

### 7. Upbeat Endings

**Looks like:** "The future looks bright", "Exciting times ahead", "This is a major step in the right direction".
**Do this:** End on the last concrete fact.

### 8. Guessing Instead of Saying "Unknown"

**Looks like:** "While details are limited...", "it is believed that...", "she likely grew up...", "maintains a low profile".
**Do this:** Say what is not known in one sentence, or cut it. Do not dress a guess up as a fact.

### 9. Big-Truth Phrases

**Looks like:** "The real question is...", "At its core...", "What really matters is...", "the heart of the matter".
**Do this:** Say the point directly.

### 10. Aphorisms and Staccato Punchlines

**Looks like:** "X is the language of trust", "Efficiency becomes a trap", or a run of short fragments for drama ("No setup. No config. No limits.").
**Do this:** Replace the slogan with the plain claim it points at. One short sentence for emphasis is fine, a run of them is not.

### 11. Fake-Candid Openers

**Looks like:** "Honestly?", "Look,", "Here's the thing", "Let's be real".
**Do this:** Delete the opener and say the thing.

## Word and Grammar Patterns

### 12. AI Vocabulary

**Looks like:** additionally, align with, crucial, delve, enduring, enhance, foster, garner, highlight (as a verb), intricate, key (as an adjective), landscape (for an abstract area), pivotal, showcase, tapestry, testament, underscore, valuable, vibrant.
**Do this:** Use a familiar word with the same meaning; consult `references/languages/english.md` when useful. These words are a problem mostly when several show up together. Keep established technical uses.

### 13. Fancy Replacements for "is" and "has"

**Looks like:** "serves as", "stands as", "represents", "boasts", "features", "offers".
**Do this:** Use "is", "are", or "has" when that preserves the claim. Keep verbs that express a real action or relationship.

Before: "The module serves as the entry point and features three exported functions."
After: "The module is the entry point. It exports three functions."

### 14. "Not Just X, But Y"

**Looks like:** "It's not just a tool, it's a way of working", "not only fast but also secure". Also clipped tails such as "no guessing" or "no hassle" added after a sentence.
**Do this:** State the real claim once, as a full clause.

Before: "The CLI picks the right option for you, no guessing."
After: "The CLI picks the right option for you, so you do not have to guess."

### 15. Groups of Three

**Looks like:** three items or three adjectives every time, only because three sounds complete.
**Do this:** Use as many items as you really have.

### 16. Synonym Cycling

**Looks like:** calling the same thing "the user", "the individual", "the end user", and "the person" in four sentences.
**Do this:** Pick one word and repeat it. Repeating a word is fine.

### 17. False Ranges

**Looks like:** "from the dawn of computing to the future of AI", where the two ends are not on one scale.
**Do this:** List the actual topics.

### 18. Hidden Actors

**Looks like:** "No configuration needed.", "The results are preserved automatically.", "It can be seen that...".
**Do this:** Name who does what when the actor matters: "You do not need a configuration file." "The service saves the results." Natural passive wording is fine when the actor is unknown or irrelevant.

## Format and Punctuation Patterns

### 19. Dashes

**Default:** Use a period, a comma, a colon, or parentheses instead of decorative em dashes (—), en dashes (–), or " -- " in prose.
**Exception:** If the user gives a sample of their own writing that uses em dashes, match their habit. Text inside quotes stays as it is.

### 20. Too Much Bold

**Looks like:** bold on every key term or phrase.
**Do this:** Keep selective bold when it helps scanning or marks an important warning. Remove emphasis that makes every phrase compete for attention.

### 21. Bold-Label Bullets

**Looks like:** `- **Performance:** Performance has been improved...` where the label repeats the sentence.
**Do this:** Write one normal sentence or short paragraph. Use a list when the items are really separate steps or parts. Keep labels only when they distinguish useful categories rather than repeat the sentence.

### 22. Emoji

**Looks like:** emoji in headings or at the start of bullets.
**Do this:** Remove them, unless the user or the doc style asks for emoji.

### 23. Curly Quotes

**Looks like:** curly quotation marks around text.
**Do this:** Use straight quotes. (Exception: text you must keep exactly as given.)

### 24. Padding After a Heading

**Looks like:** a heading followed by a one-line sentence that only repeats the heading ("Speed matters." under "Performance").
**Do this:** Delete the sentence and start with the content.

### 25. Docs That Tell a Change Story

**Looks like:** "This function was added to replace the old loop", in a doc that is not a changelog.
**Do this:** Describe the thing as it is now. Only changelogs, release notes, and migration guides talk about what changed.

### 26. Headings: Do Not Change the Case

Some guides say AI uses Title Case headings and tell you to switch to sentence case. In this setup, Title Case is the chosen style for docs. Leave heading case alone.

## Chat Leftovers

### 27. Helper Lines

**Looks like:** "I hope this helps!", "Let me know if you'd like...", "Certainly!", "Here is a...", "Want me to give examples?".
**Do this:** Delete them. In a chat answer, one short offer to go deeper at the end is allowed. In a document or file, no offers at all.

### 28. Flattery

**Looks like:** "Great question!", "You're absolutely right!", "That's an excellent point".
**Do this:** Delete it and answer.

### 29. Announcements

**Looks like:** "Let's dive in", "Let's break this down", "Here's what you need to know", "Without further ado".
**Do this:** Start with the content.

### 30. Cutoff and Gap Disclaimers

**Looks like:** "As of my last update...", "based on available information", "specific details are not publicly available".
**Do this:** Say what you do not know in one plain sentence, or cut it.

## Filler and Hedging

### 31. Filler Phrases

| Instead of | Write |
|---|---|
| in order to | to |
| due to the fact that | because |
| at this point in time | now |
| in the event that | if |
| has the ability to | can |
| it is important to note that | (delete it) |
| a large number of | many |

### 32. Too Many Hedges

**Looks like:** "could potentially possibly", "might perhaps have some effect".
**Do this:** One hedge, only where you are truly unsure, and say what you are unsure about.

### 33. Hyphenated Pairs

Do not worry about hyphens in pairs like "high-quality" or "data-driven". It is a weak signal and not worth changing.
