@isTest
private class lo_test_initial {

    static testMethod void initial_zeroCount_returnsEmptyList() {
        List<String> testSource = new List<String>();

        Test.startTest();

        List<Object> results = lo.initial(testSource);

        Test.stopTest();

        System.assertEquals(0, results.size(), 'Did not get the expected number of results');
    }

    static testMethod void initial_tenCount_returnsNineItemsList() {
        List<String> testSource = new List<String>{
            'a',
            'b',
            'c',
            'd',
            'e',
            'f',
            'g',
            'h',
            'i',
            'j'
        };

        Test.startTest();

        List<Object> results = lo.initial(testSource);

        Test.stopTest();

        List<String> expectedResults = new List<String>{
            'a',
            'b',
            'c',
            'd',
            'e',
            'f',
            'g',
            'h',
            'i'
        };

        System.assertEquals(9, results.size(), 'Did not get the expected number of results');
        System.assertNotEquals('j', results[results.size() - 1], 'Unexpected value for last index');

        for(Integer i = 0; i < results.size(); i++){
            System.assertEquals(expectedResults.get(i), (String)(results.get(i)), 'Did not get the expected value at slot ' + i);
        }
    }

    static testMethod void initial_nullCollection_returnsEmptyList() {
        List<Object> testSource;

        Test.startTest();

        List<Object> results = lo.initial(testSource);

        Test.stopTest();

        System.assertEquals(0, results.size(), 'Did not get the expected number of results');
    }
}