# Power Dashboard Guide

## What It Is
`/power-dashboard` is a command-driven workflow for tool, queue, and scissor-lift operations.

## Core Workflow
1. Select a resource by scanning/typing it in the input.
2. Run an action command (`checkin`, `checkout`, `queue add ...`, etc.).
3. Confirm when prompted.

The page keeps current context in session (selected borrower, org, tool/lift, tools cart).

## Resource Inputs
You can type/scan:
- Tool barcode
- Participant ID or searchable participant value
- Organization value
- Scissor lift name

Tip: click the input to see autocomplete suggestions.

## Commands

### Tool Cart / Tool Actions
- `add` or `a`: add current tool to tools cart
- `remove` or `rem` or `r`: remove current tool (or barcode) from tools cart
- `checkout` or `out`: checkout tools cart to selected borrower/org
- `checkout cart` or `checkout c` or `checkout tool` or `checkout tools`: checkout tools cart to selected borrower/org
- `checkin` or `in`: checkin current tool
- `checkin cart` or `in cart`: checkin all tools in cart
- `checkin c` or `in c` or `checkin tool` or `checkin tools`: checkin all tools in cart

### Lift Actions
- `checkout lift` (or `checkout l`, `out lift`, `out l`): checkout selected/available scissor lift to selected borrower/org
- `checkin lift` (or `checkin l`, `in lift`, `in l`): checkin current scissor lift
- `renew <hours>` or `ren <hours>`: renew current scissor lift
- `forfeit`: forfeit current scissor lift
- `lifts`: show scissor-lift overview

### Queue Actions
- `electrical` or `e`: select electrical queue
- `structural` or `s`: select structural queue
- `queue add <message>` / `q add <message>` / `queue a <message>` / `q a <message>` / `electrical add <message>` / `e add <message>` / `structural add <message>` / `s add <message>`: add org to queue with message
- `queue remove` / `q remove` / `queue rem` / `queue r` / `q rem` / `q r` / `electrical remove` / `e rem` / `structural remove` / `s rem`: remove org from queue

### Session / Utility
- `auto`: toggle auto-add tools mode
- `clear`: clear power dashboard session state

## Confirmation
These actions require confirmation:
- `checkin` (tool)
- `checkin cart`
- `checkin lift`
- `checkout` (tools cart)
- `checkout lift`
- `renew <hours>`
- `forfeit`
- `queue add <message>`

On confirm page:
- `Confirm` executes
- `Cancel` aborts
- `Ctrl+Enter` also confirms

## Required Context (Common Errors)
- "Select a participant first": set borrower before checkout flows.
- "Select an organization first": set org when required.
- "Tools cart is empty": add tools before cart actions.
- "Select a tool or scissor lift first": select resource before `checkin`.
- "Provide hours to renew": use `renew <hours>`.
- "Select a queue first": choose `electrical` or `structural` before queue add/remove.

## Examples
- Scan tool `12345` -> `add` -> scan participant -> scan org -> `checkout`
- Scan lift `SL-02` -> `checkin lift` -> confirm
- Scan lift `SL-02` -> `in l` -> confirm
- `electrical` -> scan org -> `queue add Need breaker reset`

## Quick Reset
If state gets confusing, run:
- `clear`

That resets selected resource, borrower/org context, and pending action state.
