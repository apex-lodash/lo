@isTest
private class lo_test_union {
	static testMethod void union_nullCollection_returnsEmptyCollection() {
		List<List<String>> collection = null;

		Test.startTest();

		List<Object> results = lo.union(collection);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Should have gotten an empty collection back');
	}

	static testMethod void union_emptyCollection_returnsEmptyCollection() {
		List<List<String>> collection = new List<List<String>>();

		Test.startTest();

		List<Object> results = lo.union(collection);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Should have gotten an empty collection back');
	}

	static testMethod void union_singleCollection_returnsSingleCollection() {
		List<List<String>> collection = new List<List<String>>{
			new List<String> {
				'alpha',
				'bravo'
			}
		};

		Test.startTest();

		List<Object> results = lo.union(collection);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'alpha',
			'bravo'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected result back at index ' + i);
		}
	}

	static testMethod void union_multipleCollection_returnsSingleCollection() {
		List<List<String>> collection = new List<List<String>>{
			new List<String> {
				'alpha',
				'bravo'
			},
			new List<String> {
				'charlie',
				'delta'
			},
			new List<String>(),
			new List<String> {
				'echo'
			}
		};

		Test.startTest();

		List<Object> results = lo.union(collection);

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
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected result back at index ' + i);
		}
	}
}