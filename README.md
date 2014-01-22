T9 Coding Challenge
===================

Written by Zev Youra.

A basic implementation of a T9-like typing system. The word list is generated from the sample linux words file available [here](http://www.cs.duke.edu/~ola/ap/linuxwords). 

Ambiguities in the spec
-----------------------
- Zeroes and ones are stripped from the number sequence before processing.
- Proper nouns are included in the lookup trie, but do not get matched because matching is case sensitive and numbers only map to lower-case letters.

Potential improvements
----------------------
- UI and visual polish (animation, loading indicator, etc.)
- Cross-browser testing
- Unit tests
- Could serve the trie directly instead of creating it on the client to improve load time