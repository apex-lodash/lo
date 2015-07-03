@isTest
private class lo_test_drop {
	private class DropObject {
		public String testString;

		public DropObject(String s) {
			this.testString = s;
		}
	}

	static testMethod void drop_single_noElements_returnsEmptyList() {
		List<DropObject> collection = new List<DropObject>();

		Test.startTest();

		List<Object> results = (List<Object>)(lo.drop(collection));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void drop_single_oneElement_returnsEmptyList() {
		List<DropObject> collection = new List<DropObject>{
			new DropObject('item 1')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.drop(collection));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void drop_single_threeElements_returnsTwoElements() {
		List<DropObject> collection = new List<DropObject>{
			new DropObject('Item 1'),
			new DropObject('Item 2'),
			new DropObject('Item 3')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.drop(collection));

		Test.stopTest();

		// Doing this in an ordered list since the result order does matter
		List<String> expectedResults = new List<String>{
			'Item 2',
			'Item 3'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < results.size(); i++) {
			DropObject result = (DropObject)(results.get(i));
			System.assertEquals(expectedResults.get(i), result.testString, 'Did not get the expected results at ' + i);
		}
	}

	static testMethod void drop_double_noElements_dropTwo_returnsEmptyList() {
		List<DropObject> collection = new List<DropObject>();

		Test.startTest();

		List<Object> results = (List<Object>)(lo.drop(collection, 2));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void drop_double_twoElements_dropTwo_returnsEmptyList() {
		List<DropObject> collection = new List<DropObject>{
			new DropObject('Item 1'),
			new DropObject('Item 2')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.drop(collection, 2));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void drop_double_tenElements_dropFive_returnsEmptyList() {
		List<DropObject> collection = new List<DropObject>{
			new DropObject('Item 1'),
			new DropObject('Item 2'),
			new DropObject('Item 3'),
			new DropObject('Item 4'),
			new DropObject('Item 5'),
			new DropObject('Item 6'),
			new DropObject('Item 7'),
			new DropObject('Item 8'),
			new DropObject('Item 9'),
			new DropObject('Item 10')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.drop(collection, 5));

		Test.stopTest();

		// Doing this in an ordered list since the result order does matter
		List<String> expectedResults = new List<String>{
			'Item 6',
			'Item 7',
			'Item 8',
			'Item 9',
			'Item 10'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < results.size(); i++) {
			DropObject result = (DropObject)(results.get(i));
			System.assertEquals(expectedResults.get(i), result.testString, 'Did not get the expected results at ' + i);
		}
	}
}