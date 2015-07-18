@isTest
private class lo_test_rest {
	static testMethod void rest_nullList_returnsEmptyList() {
		List<String> testList = null;

		Test.startTest();

		List<Object> results = lo.rest(testList);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected results back');
	}

	static testMethod void rest_emptyList_returnsEmptyList() {
		List<String> testList = new List<String>();

		Test.startTest();

		List<Object> results = lo.rest(testList);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected results back');
	}

	static testMethod void rest_singleItemList_returnsEmptyList() {
		List<String> testList = new List<String>{
			'alpha'
		};

		Test.startTest();

		List<Object> results = lo.rest(testList);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected results back');
	}

	static testMethod void rest_multiItemList_returnsCorrectList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};

		Test.startTest();

		List<Object> results = lo.rest(testList);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'bravo',
			'charlie',
			'delta'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected result back in slot ' + i);
		}
	}
}