@isTest
private class lo_test_last {
	static testMethod void last_emptyList_returnNull() {
		List<String> testList = new List<String>();

		Test.startTest();

		Object result = lo.last(testList);

		Test.stopTest();

		System.assertEquals(null, result, 'Did not get the expected result back');
	}

	static testMethod void last_nullList_returnNull() {
		List<String> testList = null;

		Test.startTest();

		Object result = lo.last(testList);

		Test.stopTest();

		System.assertEquals(null, result, 'Did not get the expected result back');
	}

	static testMethod void last_populatedList_returnLast() {
		List<String> testList = new List<String>{
			'alpha',
			'bravo',
			'charlie',
			'delta'
		};

		Test.startTest();

		Object result = lo.last(testList);

		Test.stopTest();

		System.assertEquals('delta', (String)(result), 'Did not get the expected result back');
	}
}