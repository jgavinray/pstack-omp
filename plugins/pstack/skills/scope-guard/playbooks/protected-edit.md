### Protected-path edit

1. Quote the user's request verbatim. Write the enumeration table:

   ```
   user said: <verbatim request>
   fields named verbatim: <list, or "none">
   fields I plan to touch: <exact list>
   delta: <named only | inferred: <which and why>>
   ```

   A request that names a domain but no fields has `fields named verbatim: none`.
   That is the table's most important row. Do not soften it.

2. `cp <target> <target>.bak-<date>-pre-<change>` before any edit. Always, even
   for a one-line change. The backup is the recovery path this design depends on.

3. Draft the edit. Write the user request to one temp file and the planned
   field list plus values to another. Run
   `bash <skill-dir>/scripts/scope-check.sh <request-file> <plan-file>`.
   Capture the advisory line.

4. Verdict `within_mandate` or adjudicator unreachable with an empty delta:
   apply exactly the checked diff, nothing adjacent.

5. Verdict `adjacent_widening` or `unrelated_change` or adjudicator
   unreachable with an inferred delta: do not stop. Apply the narrowest
   reading of the request, drop the widening fields, and show the advisory
   line, the enumeration table, and the dropped fields in your reply. If the
   widening fields are load-bearing for what the user asked, ask which fields
   they meant, with the table inline.

6. Reply contract: the advisory line (or the unreachable notice), the user's
   request quoted verbatim, the enumeration table, and the backup path. A
   protected-path edit whose reply lacks these is the failure signal.

This playbook never blocks a write. It makes silent drift expensive and
recoverable: visible verdict, visible delta, one-command revert.
