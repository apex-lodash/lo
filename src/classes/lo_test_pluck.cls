@isTest
private class lo_test_pluck {
	private class BazTest {
		public String testString;

		public BazTest(String s) {
			this.testString = s;
		}
	}

	private class BarTest {
		public BazTest baz;

		public BarTest(String s) {
			this.baz = new BazTest('bar:' + s);
		}
	}

	private class FooTest {
		public String testString;
		public Integer testInteger;
		public BarTest bar;

		public FooTest(String s, Integer i) {
			this.testString = s;
			this.testInteger = i;
			this.bar = new BarTest('foo:' + s);
		}
	}

	static testMethod void pluck_customObject_singleLevel_string() {
		lo.LOGGING = true;

		List<FooTest> testList = new List<FooTest>{
			new FooTest('foo0', 0),
			new FooTest('foo1', 1),
			new FooTest('foo2', 2),
			new FooTest('foo3', 3),
			new FooTest('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'testString');

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'foo0',
			'foo1',
			'foo2',
			'foo3',
			'foo4'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < expectedResults.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the correct result back in slot ' + i);
		}
	}

	static testMethod void pluck_customObject_singleLevel_integer() {
		lo.LOGGING = true;

		List<FooTest> testList = new List<FooTest>{
			new FooTest('foo0', 0),
			new FooTest('foo1', 1),
			new FooTest('foo2', 2),
			new FooTest('foo3', 3),
			new FooTest('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'testInteger');

		Test.stopTest();

		List<Integer> expectedResults = new List<Integer>{
			0,
			1,
			2,
			3,
			4
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < expectedResults.size(); i++) {
			System.assertEquals(expectedResults.get(i), (Integer)(results.get(i)), 'Did not get the correct result back in slot ' + i);
		}
	}

	static testMethod void pluck_customObject_singleLevel_unknownKey() {
		lo.LOGGING = true;

		List<FooTest> testList = new List<FooTest>{
			new FooTest('foo0', 0),
			new FooTest('foo1', 1),
			new FooTest('foo2', 2),
			new FooTest('foo3', 3),
			new FooTest('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'unknownKey');

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of results back');
	}

	static testMethod void pluck_customObject_multiLevel() {
		lo.LOGGING = true;

		List<FooTest> testList = new List<FooTest>{
			new FooTest('foo0', 0),
			new FooTest('foo1', 1),
			new FooTest('foo2', 2),
			new FooTest('foo3', 3),
			new FooTest('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'bar.baz.testString');

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'bar:foo:foo0',
			'bar:foo:foo1',
			'bar:foo:foo2',
			'bar:foo:foo3',
			'bar:foo:foo4'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < expectedResults.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the correct result back in slot ' + i);
		}
	}

	static testMethod void pluck_customObject_multiLevel_unknownKey() {
		lo.LOGGING = true;

		List<FooTest> testList = new List<FooTest>{
			new FooTest('foo0', 0),
			new FooTest('foo1', 1),
			new FooTest('foo2', 2),
			new FooTest('foo3', 3),
			new FooTest('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'bar.unknownKey.testString');

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of results back');
	}

	static testMethod void pluck_sObject_singleLevel() {
		List<String> accountNames = new List<String> {
			'_unittest_account_0: ' + Datetime.now().getTime(),
			'_unittest_account_1: ' + Datetime.now().getTime(),
			'_unittest_account_2: ' + Datetime.now().getTime(),
			'_unittest_account_3: ' + Datetime.now().getTime(),
			'_unittest_account_4: ' + Datetime.now().getTime()
		};

		List<Account> testAccounts = new List<Account>();

		for (Integer i = 0; i < accountNames.size(); i++) {
			testAccounts.add(new Account(Name = accountNames.get(i)));
		}

		Test.startTest();

		List<Object> results = lo.pluck(testAccounts, 'Name');

		Test.stopTest();

		System.assertEquals(accountNames.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < accountNames.size(); i++) {
			System.assertEquals(accountNames.get(i), (String)(results.get(i)), 'Did not get the epxceted result at slot ' + i);
		}
	}

	static testMethod void pluck_sObject_multiLevel() {
		Integer objCount = 5;

		List<String> accountNames = new List<String> {
			'_unittest_account_0: ' + Datetime.now().getTime(),
			'_unittest_account_1: ' + Datetime.now().getTime(),
			'_unittest_account_2: ' + Datetime.now().getTime(),
			'_unittest_account_3: ' + Datetime.now().getTime(),
			'_unittest_account_4: ' + Datetime.now().getTime()
		};

		List<Account> testAccounts = new List<Account>();

		for (Integer i = 0; i < objCount; i++) {
			testAccounts.add(new Account(Name = accountNames.get(i)));
		}

		insert testAccounts;

		List<Contact> testContacts = new List<Contact>();

		for (Integer i = 0; i < objCount; i++) {
			testContacts.add(new Contact(
				AccountId = testAccounts.get(i).Id,
				LastName = '_unittest_contact_' + i + ': ' + Datetime.now().getTime()
			));
		}

		insert testContacts;

		List<Case> testCases = new List<Case>();

		for (Integer i = 0; i < objCount; i++) {
			testCases.add(new Case(
				ContactId = testContacts.get(i).Id,
				Subject = '_unittest_case_' + i + ': ' + Datetime.now().getTime()
			));
		}

		insert testCases;

		Map<Id, Case> caseMap = new Map<Id, Case>(testCases);

		List<Case> testCollection = [
			select Contact.Account.Name
			from Case
			where Id in :caseMap.keySet()
			order by Contact.Account.Name
		];

		Test.startTest();

		List<Object> results = lo.pluck(testCollection, 'Contact.Account.Name');

		Test.stopTest();

		System.assertEquals(accountNames.size(), results.size(), 'Did not get the expected number of results');

		for (Integer i = 0; i < accountNames.size(); i++) {
			System.assertEquals(accountNames.get(i), (String)(results.get(i)), 'Did not get the epxceted result at slot ' + i);
		}
	}

	static testMethod void pluck_sObject_multiLevel_unQueriedField() {
		Integer objCount = 5;

		List<String> accountNames = new List<String> {
			'_unittest_account_0: ' + Datetime.now().getTime(),
			'_unittest_account_1: ' + Datetime.now().getTime(),
			'_unittest_account_2: ' + Datetime.now().getTime(),
			'_unittest_account_3: ' + Datetime.now().getTime(),
			'_unittest_account_4: ' + Datetime.now().getTime()
		};

		List<Account> testAccounts = new List<Account>();

		for (Integer i = 0; i < objCount; i++) {
			testAccounts.add(new Account(Name = accountNames.get(i)));
		}

		insert testAccounts;

		List<Contact> testContacts = new List<Contact>();

		for (Integer i = 0; i < objCount; i++) {
			testContacts.add(new Contact(
				AccountId = testAccounts.get(i).Id,
				LastName = '_unittest_contact_' + i + ': ' + Datetime.now().getTime()
			));
		}

		insert testContacts;

		List<Case> testCases = new List<Case>();

		for (Integer i = 0; i < objCount; i++) {
			testCases.add(new Case(
				ContactId = testContacts.get(i).Id,
				Subject = '_unittest_case_' + i + ': ' + Datetime.now().getTime()
			));
		}

		insert testCases;

		Map<Id, Case> caseMap = new Map<Id, Case>(testCases);

		List<Case> testCollection = [
			select Contact.Account.Name
			from Case
			where Id in :caseMap.keySet()
			order by Contact.Account.Name
		];

		Test.startTest();

		List<Object> results = lo.pluck(testCollection, 'Contact.Account.AccountNumber');

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of results');
	}
}