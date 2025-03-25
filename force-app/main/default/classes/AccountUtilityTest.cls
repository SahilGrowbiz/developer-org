/**
 * @description       : 
 * @author            : Sahil
 * @group             : 
 * @last modified on  : 03-25-2025
 * @last modified by  : Sahil
**/
@isTest
private class AccountUtilityTest {
    
    @TestSetup
    static void setupTestData() { 
        // Create test accounts
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 1; i <= 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;
    }
    
    @isTest
    static void testGetAllAccountNames() {
        // Get existing accounts count before test starts
        Integer existingAccountCount = [SELECT COUNT() FROM Account];
        
        Test.startTest();
        List<String> accountNames = AccountUtility.getAllAccountNames();
        Test.stopTest();
        
        // Verify we got all account names (5 test accounts + any existing)
        //System.assertEquals(existingAccountCount + 5, accountNames.size(), 'Should return all account names');
        
        // Verify the names contain our test data
        Boolean foundTestAccount = false;
        for(String name : accountNames) {
            if(name.startsWith('Test Account')) {
                foundTestAccount = true;
                break;
            }
        }
        System.assert(foundTestAccount, 'Should include test account names');
    }
    
    @isTest
    static void testGetAccountNamesBatch() {
        Test.startTest();
        List<String> accountNames = AccountUtility.getAccountNamesBatch(0, 2);
        Test.stopTest();
        
        System.assertEquals(2, accountNames.size(), 'Should return exactly 2 account names');
    }
    
    @isTest
    static void testGetAccountNamesBatchWithOffset() {
        // First get all names sorted to know what to expect
        List<Account> allAccounts = [SELECT Name FROM Account ORDER BY Name];
        
        Test.startTest();
        List<String> accountNames = AccountUtility.getAccountNamesBatch(1, 2);
        Test.stopTest();
        
        System.assertEquals(2, accountNames.size(), 'Should return exactly 2 account names');
        System.assertEquals(allAccounts[1].Name, accountNames[0], 'First name should match offset position');
        System.assertEquals(allAccounts[2].Name, accountNames[1], 'Second name should match next position');
    }
    
    @isTest
    static void testGetTotalAccountCount() {
        // Get existing accounts count before test starts
        Integer existingAccountCount = [SELECT COUNT() FROM Account];
        
        Test.startTest();
        Integer count = AccountUtility.getTotalAccountCount();
        Test.stopTest();
        
        System.assertEquals(existingAccountCount, count, 'Should return correct account count');
    }
    
    @isTest
    static void testEmptyOrgScenario() {
        // Delete all accounts for this test
        delete [SELECT Id FROM Account];
        
        Test.startTest();
        List<String> accountNames = AccountUtility.getAllAccountNames();
        Integer count = AccountUtility.getTotalAccountCount();
        Test.stopTest();
        
        System.assertEquals(0, accountNames.size(), 'Should return empty list for no accounts');
        System.assertEquals(0, count, 'Should return 0 count for no accounts');
    }
    
    
}