keyMap =
	'2': ['a', 'b', 'c']
	'3': ['d', 'e', 'f']
	'4': ['g', 'h', 'i']
	'5': ['j', 'k', 'l']
	'6': ['m', 'n', 'o']
	'7': ['p', 'q', 'r', 's']
	'8': ['t', 'u', 'v']
	'9': ['w', 'x', 'y', 'z']

getPossibleWords = (numberSequence) ->
	if typeof numberSequence is 'number' # allow flexible input
		numberSequence = numberSequence.toString()
	numberSequence = numberSequence.replace(/[01]/g, '') # ignore zeroes and ones
	numberSequence = numberSequence.split('')
	# at this point, numberSequence is something like ['1', '2', '3', ... ]

	return numberSequence

console.log getPossibleWords 12345