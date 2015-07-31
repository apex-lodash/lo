@isTest
private class lo_test_takeRight {
	static testMethod void takeRight_emptyList_returnsEmptyList() {
		List<String> collection = new List<String>();

		Test.startTest();

		List<Object> results = lo.takeRight(collection, 3);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Should have gotten an empty list back');
	}

	static testMethod void takeRight_nullList_returnsEmptyList() {
		List<String> collection = null;

		Test.startTest();

		List<Object> results = lo.takeRight(collection, 3);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Should have gotten an empty list back');
	}

	static testMethod void takeRight_populatedListTooFew_returnsEmptyList() {
		List<String> collection = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta',
			'echo'
		};

		Test.startTest();

		List<Object> results = lo.takeRight(collection, -10);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Should not have gotten any results back');
	}

	static testMethod void takeRight_populatedList_returnsPartialList() {
		List<String> collection = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta',
			'echo'
		};

		Test.startTest();

		List<Object> results = lo.takeRight(collection, 3);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'charlie',
			'delta',
			'echo'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected result at slot ' + i);
		}
	}

	static testMethod void takeRight_populatedListTooMany_returnsFullList() {
		List<String> collection = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta',
			'echo'
		};

		Test.startTest();

		List<Object> results = lo.takeRight(collection, 100);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta',
			'echo'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected result at slot ' + i);
		}
	}
}