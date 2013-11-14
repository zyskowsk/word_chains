Word Chains
===========
steve was here

This is my solution the the [word chains ruby quiz](http://web.archive.org/web/20120121221612/http://rubyquiz.com/quiz44.html).

#### Description
A script that finds a chain of words from one word to another, where each word
in the chain is a dictionary word, and differs form the previous word by exactly one letter.
Returns false if no chain exists.  My algorithm uses a breadth first search approach.

Example:

    > word_chainer = WordChainer.new('dictionary.txt')
    > word_chainer.find_word_chain('plane', 'flame')
    => "plane -> plate -> slate -> slake -> flake -> flame"
    >
    > word_chainer.find_word_chain('butter', 'thrice')
    => false


