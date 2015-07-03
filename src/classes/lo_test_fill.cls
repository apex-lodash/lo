@isTest
private class lo_test_fill {
	static testMethod void fill_zeroCount_returnsEmptyList() {
		String testSource = '_teststring_: 001';

		Test.startTest();

		List<Object> results = lo.fill(testSource, 0);

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of results');
	}

	static testMethod void fill_tenCount_returnsTenItemsList() {
		String testSource = '_teststring_: 001';

		Test.startTest();

		List<Object> results = lo.fill(testSource, 10);

		Test.stopTest();

		System.assertEquals(10, results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < results.size(); i++) {
			String result = (String)(results.get(i));

			System.assertEquals(testSource, result, 'Did not get the right object back ' + i);
		}
	}
}