@isTest
private class lo_test_tostring {
	static testMethod void toString_nullCollection_returnsNull() {
		List<Object> collection = null;

		Test.startTest();

		List<String> results = lo.toString(collection);

		Test.stopTest();

		System.assertEquals(null, results, 'The returned collection should be null');
	}

	static testMethod void toString_emptyCollection_returnsEmptyList() {
		List<Object> collection = new List<Object>();

		Test.startTest();

		List<String> results = lo.toString(collection);

		Test.stopTest();

		System.assert(results.isEmpty(), 'The returned collection should be empty');
	}

	static testMethod void toString_validCollection_returnsCastedList() {
		List<String> expectedResults = new List<String>{
			'Test string 1',
			'Test string 2',
			'Test string 3',
			'Test string 4',
			'Test string 5'
		};

		List<Object> collection = (List<Object>)(JSON.deserializeUntyped(JSON.serialize(expectedResults)));

		Test.startTest();

		List<String> results = lo.toString(collection);

		Test.stopTest();

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < expectedResults.size(); i++) {
			System.assertEquals(expectedResults.get(i), results.get(i), 'Did not get the correct result back in slot ' + i);
		}
	}
}