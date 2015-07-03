@isTest
private class lo_test_dropRight {
	private class DropRightObject {
		public String testString;

		public DropRightObject(String s) {
			this.testString = s;
		}
	}

	static testMethod void dropRight_single_noElements_returnsEmptyList() {
		List<DropRightObject> collection = new List<DropRightObject>();

		Test.startTest();

		List<Object> results = (List<Object>)(lo.dropRight(collection));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void dropRight_single_oneElement_returnsEmptyList() {
		List<DropRightObject> collection = new List<DropRightObject>{
			new DropRightObject('item 1')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.dropRight(collection));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void dropRight_single_threeElements_returnsTwoElements() {
		List<DropRightObject> collection = new List<DropRightObject>{
			new DropRightObject('Item 1'),
			new DropRightObject('Item 2'),
			new DropRightObject('Item 3')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.dropRight(collection));

		Test.stopTest();

		// Doing this in an ordered list since the result order does matter
		List<String> expectedResults = new List<String>{
			'Item 1',
			'Item 2'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < results.size(); i++) {
			DropRightObject result = (DropRightObject)(results.get(i));
			System.assertEquals(expectedResults.get(i), result.testString, 'Did not get the expected results at ' + i);
		}
	}

	static testMethod void dropRight_double_noElements_dropTwo_returnsEmptyList() {
		List<DropRightObject> collection = new List<DropRightObject>();

		Test.startTest();

		List<Object> results = (List<Object>)(lo.dropRight(collection, 2));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void dropRight_double_twoElements_dropTwo_returnsEmptyList() {
		List<DropRightObject> collection = new List<DropRightObject>{
			new DropRightObject('Item 1'),
			new DropRightObject('Item 2')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.dropRight(collection, 2));

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of resultss');
	}

	static testMethod void dropRight_double_tenElements_dropFive_returnsEmptyList() {
		List<DropRightObject> collection = new List<DropRightObject>{
			new DropRightObject('Item 1'),
			new DropRightObject('Item 2'),
			new DropRightObject('Item 3'),
			new DropRightObject('Item 4'),
			new DropRightObject('Item 5'),
			new DropRightObject('Item 6'),
			new DropRightObject('Item 7'),
			new DropRightObject('Item 8'),
			new DropRightObject('Item 9'),
			new DropRightObject('Item 10')
		};

		Test.startTest();

		List<Object> results = (List<Object>)(lo.dropRight(collection, 5));

		Test.stopTest();

		// Doing this in an ordered list since the result order does matter
		List<String> expectedResults = new List<String>{
			'Item 1',
			'Item 2',
			'Item 3',
			'Item 4',
			'Item 5'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < results.size(); i++) {
			DropRightObject result = (DropRightObject)(results.get(i));
			System.assertEquals(expectedResults.get(i), result.testString, 'Did not get the expected results at ' + i);
		}
	}
}