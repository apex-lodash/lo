@isTest
private class lo_test_pluck {
	private class LevelThree {
		public String testString;

		public LevelThree(String s) {
			this.testString = s;
		}
	}

	private class LevelTwo {
		public LevelThree three;

		public LevelTwo(String s) {
			this.three = new LevelThree('two:' + s);
		}
	}

	private class LevelOne {
		public String testString;
		public Integer testInteger;
		public LevelTwo two;

		public LevelOne(String s, Integer i) {
			this.testString = s;
			this.testInteger = i;
			this.two = new LevelTwo('one:' + s);
		}
	}

	static testMethod void pluck_single_usingCustomObjectAndSingleLevelKey_returnsCastableString() {
		lo.LOGGING = true;

		LevelOne testObject = new LevelOne('foo', 100);

		Test.startTest();

		System.assertEquals('foo', (String)(lo.pluck(testObject, 'testString')), 'Did not get the correct result back');

		Test.stopTest();
	}

	static testMethod void pluck_single_usingCustomObjectAndUnknownKey_throwsException() {
		lo.LOGGING = true;
		String key = 'unknownKey';

		LevelOne testObject = new LevelOne('foo', 100);

		Test.startTest();

		try {
			Object result = lo.pluck(testObject, key);
			System.assert(false, 'Should have thrown an exception by now');
		} catch (lo.UnknownKeyException e) {
			String expectedMessage = lo.MSG_UNKNOWN_KEY + key;
			System.assertEquals(expectedMessage, e.getMessage(), 'Got the right exception type but the wrong message');
		}

		Test.stopTest();
	}

	static testMethod void pluck_single_usingCustomObjectAndMultiLevelKey_returnsCastableString() {
		lo.LOGGING = true;

		LevelOne testObject = new LevelOne('foo', 100);

		Test.startTest();

		System.assertEquals('two:one:foo', (String)(lo.pluck(testObject, 'two.three.testString')), 'Did not get the correct result back');

		Test.stopTest();
	}

	static testMethod void pluck_single_usingCustomObjectAndMultiLevelUnknownKey_throwsException() {
		lo.LOGGING = true;
		String key = 'unknownKey';

		LevelOne testObject = new LevelOne('foo', 100);

		Test.startTest();

		try {
			Object result = lo.pluck(testObject, 'two.three.' + key);
			System.assert(false, 'Should have thrown an exception by now');
		} catch (lo.UnknownKeyException e) {
			String expectedMessage = lo.MSG_UNKNOWN_KEY + key;
			System.assertEquals(expectedMessage, e.getMessage(), 'Got the right exception type but the wrong message');
		}

		Test.stopTest();
	}

	static testMethod void pluck_single_usingSObjectAndSingleLevelKey_returnsCastableString() {
		String accountName = '_unittest_account_0: ' + Datetime.now().getTime();

		Account testAccount = new Account(Name = accountName);

		Test.startTest();

		System.assertEquals(accountName, (String)(lo.pluck(testAccount, 'Name')), 'Did not get the expected result back');

		Test.stopTest();
	}

	static testMethod void pluck_single_usingSObjectAndMultiLevelKey_returnsCastableString() {
		String accountName = '_unittest_account_0: ' + Datetime.now().getTime();

		Account testAccount = new Account(Name = accountName);
		insert testAccount;

		Contact testContact = new Contact(
			AccountId = testAccount.Id,
			LastName = '_unittest_contact_: ' + Datetime.now().getTime()
		);
		insert testContact;

		testContact = [
			select Account.Name
			from Contact
			where Id = :testContact.Id
		];

		Test.startTest();

		System.assertEquals(accountName, (String)(lo.pluck(testContact, 'Account.Name')), 'Did not get the expected result back');

		Test.stopTest();
	}

	static testMethod void pluck_single_usingSObjectAndUnqueriedField_throwsException() {
		String accountName = '_unittest_account_0: ' + Datetime.now().getTime();
		String key = 'AccountNumber';

		Account testAccount = new Account(Name = accountName);
		insert testAccount;

		Contact testContact = new Contact(
			AccountId = testAccount.Id,
			LastName = '_unittest_contact_: ' + Datetime.now().getTime()
		);
		insert testContact;

		testContact = [
			select Account.Name
			from Contact
			where Id = :testContact.Id
		];

		Test.startTest();

		try {
			Object result = lo.pluck(testContact, 'Account.' + key);
			System.assert(false, 'Should have thrown an exception by now');
		} catch (lo.UnknownKeyException e) {
			String expectedMessage = lo.MSG_UNKNOWN_KEY + key;
			System.assertEquals(expectedMessage, e.getMessage(), 'Got the right exception type but the wrong message');
		}

		Test.stopTest();
	}

	static testMethod void pluck_list_usingCustomObjectAndSingleLevelKey_returnsListOfCastableStringList() {
		lo.LOGGING = true;

		List<LevelOne> testList = new List<LevelOne>{
			new LevelOne('foo0', 0),
			new LevelOne('foo1', 1),
			new LevelOne('foo2', 2),
			new LevelOne('foo3', 3),
			new LevelOne('foo4', 4)
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

	static testMethod void pluck_list_usingCustomObjectAndUnknownKey_returnsEmptyList() {
		lo.LOGGING = true;

		List<LevelOne> testList = new List<LevelOne>{
			new LevelOne('foo0', 0),
			new LevelOne('foo1', 1),
			new LevelOne('foo2', 2),
			new LevelOne('foo3', 3),
			new LevelOne('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'unknownKey');

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of results back');
	}

	static testMethod void pluck_list_usingCustomObjectAndMultiLevelKey_returnsListOfCastableStringList() {
		lo.LOGGING = true;

		List<LevelOne> testList = new List<LevelOne>{
			new LevelOne('foo0', 0),
			new LevelOne('foo1', 1),
			new LevelOne('foo2', 2),
			new LevelOne('foo3', 3),
			new LevelOne('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'two.three.testString');

		Test.stopTest();

		List<String> expectedResults = new List<String>{
			'two:one:foo0',
			'two:one:foo1',
			'two:one:foo2',
			'two:one:foo3',
			'two:one:foo4'
		};

		System.assertEquals(expectedResults.size(), results.size(), 'Did not get the expected number of results back');

		for (Integer i = 0; i < expectedResults.size(); i++) {
			System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the correct result back in slot ' + i);
		}
	}

	static testMethod void pluck_list_usingCustomObjectAndMultiLevelUnknownKey_returnsEmptyList() {
		lo.LOGGING = true;

		List<LevelOne> testList = new List<LevelOne>{
			new LevelOne('foo0', 0),
			new LevelOne('foo1', 1),
			new LevelOne('foo2', 2),
			new LevelOne('foo3', 3),
			new LevelOne('foo4', 4)
		};

		Test.startTest();

		List<Object> results = lo.pluck(testList, 'two.unknownKey.testString');

		Test.stopTest();

		System.assertEquals(0, results.size(), 'Did not get the expected number of results back');
	}

	static testMethod void pluck_list_usingSObjectAndSingleLevelKey_returnsListOfCastableStringList() {
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

	static testMethod void pluck_list_usingSObjectAndMultiLevelKey_returnsListOfCastableStringList() {
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

	static testMethod void pluck_list_usingSObjectAndMultiLevelUnqueriedField_returnsEmptyList() {
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