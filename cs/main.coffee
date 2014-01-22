t9App = angular.module('t9App', []);

t9App.controller('T9Controller', ($scope, $http) ->
	$scope.input = ""
	$scope.maxInputLength = 10

	$http.get('data.json').success (data) ->
		$scope.words = data.words
		$scope.keys = data.keys
		$scope.suggestions = ['a', 'b', 'c']

	$scope.keydown = (e) ->
		if e.keyCode == 8 # backspace key
			e.preventDefault() # do not go back in history
			$scope.input = $scope.input[0...$scope.input.length - 1]
	
	$scope.keypress = (e) ->
		if e.keyCode >= 48 and e.keyCode <= 57 # number pressed
			e.preventDefault()
			$scope.input += (e.keyCode - 48).toString()

	$scope.dial = (numPressed) ->
		$scope.input += numPressed

	$scope.$watch 'input', (current, old) ->
		$scope.input = $scope.input.replace(/[\D]/gi, '')
		if $scope.input.length > $scope.maxInputLength
			$scope.input = $scope.input[0...$scope.maxInputLength]

)

getPossibleWords = (numberSequence) ->
	if typeof numberSequence is 'number' # allow flexible input
		numberSequence = numberSequence.toString()
	numberSequence = numberSequence.replace(/[01]/g, '') # ignore zeroes and ones
	numberSequence = numberSequence.split('')
	# at this point, numberSequence is something like ['1', '2', '3', ... ]

	return numberSequence