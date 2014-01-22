t9App = angular.module('t9App', []);

t9App.controller('T9Controller', ($scope, $http) ->
	$scope.input = "2273"
	$scope.onlyShowWords = true
	$scope.trie = {}
	$scope.suggestions = []
	# $scope.maxInputLength = 10 # if commented out, no limit

	# get wordlist and key values
	$http.get('data.json').success (data) ->
		$scope.words = data.words
		$scope.trie = $scope.buildTrie $scope.words
		$scope.keys = data.keys
		$scope.updateSuggestions()

	# set up watchers on model to update suggestions when necessary
	$scope.$watch 'input', (current, old) ->
		$scope.input = $scope.input.replace(/[\D]/gi, '') # only numbers allowed
		if $scope.maxInputLength and $scope.input.length > $scope.maxInputLength
			$scope.input = $scope.input[0...$scope.maxInputLength]
		$scope.updateSuggestions()

	$scope.$watch 'onlyShowWords', (current, old) ->
		$scope.updateSuggestions()

	$scope.buildTrie = (words) ->
		trie = {}
		for word in words
			base = trie
			for letter in word
				unless base[letter] then base[letter] = {}
				base = base[letter]
			base.word = true
		return trie

	$scope.keydown = (e) ->
		if e.keyCode == 8 # backspace key
			e.preventDefault() # do not go back in history
			$scope.input = $scope.input[0...$scope.input.length - 1]
	
	$scope.keypress = (e) ->
		if e.keyCode >= 48 and e.keyCode <= 57 # number pressed
			e.preventDefault() # do not add number to input if it's highlighted; will happen due to binding to $scope.input
			$scope.input += (e.keyCode - 48).toString()

	$scope.dial = (numPressed) ->
		$scope.input += numPressed

	$scope.updateSuggestions = () ->
		$scope.suggestions = $scope.getPossibleWords $scope.input

	$scope.lookupWordPath = (wordPath) ->
		base = $scope.trie
		for letter in wordPath
			if base[letter] then base = base[letter]
			else return false
		return true

	$scope.lookupWord = (word) ->
		base = $scope.trie
		for letter in word
			if base[letter] then base = base[letter]
			else return false
		return base.word

	$scope.getPossibleWords = (numberSequence) ->
		if typeof numberSequence is 'number' # allow flexible input
			numberSequence = numberSequence.toString()
		numberSequence = numberSequence.replace(/[01]/g, '') # ignore zeroes and ones
		numberSequence = numberSequence.split('')
		# at this point, numberSequence is something like ['1', '2', '3', ... ]
		wordPaths = ['']
		for digit in numberSequence
			newSet = []
			for wordPath in wordPaths
				for letter in $scope.keys[digit - 1].letters # index + 1 to adjust for indices
					word = wordPath + letter
					if not $scope.onlyShowWords or $scope.lookupWordPath word
						newSet.push word
			wordPaths = newSet
		if $scope.onlyShowWords
			wordPaths = wordPaths.filter (element) -> return $scope.lookupWord element
		return wordPaths
)