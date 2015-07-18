@isTest
private class lo_test_slice {
	static testMethod void slice_startAndStop_nullList_returnsEmptyList() {
		List<String> testList = null;
		Integer start = 1;
		Integer stop = 3;

		Test.startTest();

		List<Object> results = lo.slice(testList, start, stop);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected number of results back');
	}

	static testMethod void slice_startAndStop_emptyList_returnsEmptyList() {
		List<String> testList = new List<String>();
		Integer start = 1;
		Integer stop = 3;

		Test.startTest();

		List<Object> results = lo.slice(testList, start, stop);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected number of results back');
	}

	static testMethod void slice_startAndStop_startGreaterThanStop_returnsEmptyList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = 3;
		Integer stop = 1;

		Test.startTest();

		List<Object> results = lo.slice(testList, start, stop);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected number of results back');
	}

	static testMethod void slice_startAndStop_startLessThanZero_returnsCorrectList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = -1;
		Integer stop = 3;

		Test.startTest();

		List<Object> results = lo.slice(testList, start, stop);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'alpha',
			'bravo',
			'charlie'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected value at slot ' + i);
		}
	}

	static testMethod void slice_startAndStop_stopGreaterThanListSize_returnsCorrectList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = 1;
		Integer stop = 20;

		Test.startTest();

		List<Object> results = lo.slice(testList, start, stop);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'bravo',
			'charlie',
			'delta'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected value at slot ' + i);
		}
	}

	static testMethod void slice_startAndStop_correctInputs_returnsCorrectList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = 1;
		Integer stop = 3;

		Test.startTest();

		List<Object> results = lo.slice(testList, start, stop);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'bravo',
			'charlie'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected value at slot ' + i);
		}
	}

	static testMethod void slice_start_nullList_returnsEmptyList() {
		List<String> testList = null;
		Integer start = 1;

		Test.startTest();

		List<Object> results = lo.slice(testList, start);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected number of results back');
	}

	static testMethod void slice_start_emptyList_returnsEmptyList() {
		List<String> testList = new List<String>();
		Integer start = 1;

		Test.startTest();

		List<Object> results = lo.slice(testList, start);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected number of results back');
	}

	static testMethod void slice_start_startGreaterThanListSize_returnsEmptyList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = 20;

		Test.startTest();

		List<Object> results = lo.slice(testList, start);

		Test.stopTest();

		System.assert(results.isEmpty(), 'Did not get the expected number of results back');
	}

	static testMethod void slice_start_startLessThanZero_returnsCorrectList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = -1;

		Test.startTest();

		List<Object> results = lo.slice(testList, start);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected value at slot ' + i);
		}
	}

	static testMethod void slice_start_correctInputs_returnsCorrectList() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};
		Integer start = 1;

		Test.startTest();

		List<Object> results = lo.slice(testList, start);

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'bravo',
			'charlie',
			'delta'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < results.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected value at slot ' + i);
		}
	}
}