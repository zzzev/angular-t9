T9 in Angular
=============

Written by Zev Youra.

[Demo](http://zzzev.com/angular-challenge/) 

A basic implementation of a T9-like typing system. The word list is generated from the sample linux words file available [here](http://www.cs.duke.edu/~ola/ap/linuxwords).


Ambiguities
-----------
- Zeroes and ones are stripped from the number sequence before processing.
- Proper nouns are included in the lookup trie, but do not get matched because matching is case sensitive and numbers only map to lower-case letters.

Potential improvements
----------------------
- UI and visual polish (loading indicator, etc.)
- Cross-browser testing (seems to basically work in recent Chrome, FF, and Safari, but not thoroughly tested)
- Unit tests
- Could serve the trie directly instead of creating it on the client to improve load time (though the json version of the trie may be significantly larger than the wordlist that's used to create it)