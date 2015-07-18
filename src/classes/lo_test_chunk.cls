@isTest
private class lo_test_chunk {
	static testMethod void chunk_invalidN_returnsEmptyList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer n = -1;

		Test.startTest();

		List<List<Object>> result = lo.chunk(testList, n);

		Test.stopTest();

		System.assert(result.isEmpty(), 'We should have returned an empty list');
	}

	static testMethod void chunk_evenSplitN_returnsEvenSplit() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer n = 2;

		Test.startTest();

		List<List<Object>> results = lo.chunk(testList, n);

		Test.stopTest();

		List<List<String>> expectedResults = new List<List<String>>{
			new List<String>{
				'alpha',
				'bravo'
			},
			new List<String>{
				'charlie',
				'delta'
			}
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of chunks back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i).size(), results.get(i).size(), 'Did not get the expected size back in chunk ' + i);

			for (Integer j = 0; j < results.get(i).size(); j++) {
				System.assertEquals(expectedResults.get(i).get(j), (String)(results.get(i).get(j)), 'Did not get the right data back at chunk ' + i + ' spot ' + j);
			}
		}
	}

	static testMethod void chunk_unevenSplitN_returnsOffsideSplit() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer n = 3;

		Test.startTest();

		List<List<Object>> results = lo.chunk(testList, n);

		Test.stopTest();

		List<List<String>> expectedResults = new List<List<String>>{
			new List<String>{
				'alpha',
				'bravo',
				'charlie'
			},
			new List<String>{
				'delta'
			}
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of chunks back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i).size(), results.get(i).size(), 'Did not get the expected size back in chunk ' + i);

			for (Integer j = 0; j < results.get(i).size(); j++) {
				System.assertEquals(expectedResults.get(i).get(j), (String)(results.get(i).get(j)), 'Did not get the right data back at chunk ' + i + ' spot ' + j);
			}
		}
	}

	static testMethod void chunk_largeSplitN_returnsSingleChunk() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer n = 20;

		Test.startTest();

		List<List<Object>> results = lo.chunk(testList, n);

		Test.stopTest();

		List<List<String>> expectedResults = new List<List<String>>{
			new List<String>{
				'alpha',
				'bravo',
				'charlie',
				'delta'
			}
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of chunks back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i).size(), results.get(i).size(), 'Did not get the expected size back in chunk ' + i);

			for (Integer j = 0; j < results.get(i).size(); j++) {
				System.assertEquals(expectedResults.get(i).get(j), (String)(results.get(i).get(j)), 'Did not get the right data back at chunk ' + i + ' spot ' + j);
			}
		}
	}
}