/**
 * @description       : 
 * @author            : Sahil
 * @group             : 
 * @last modified on  : 03-25-2025
 * @last modified by  : Sahil
**/
public class AccountUtility {
    /**
     * Retrieves all Account names in Salesforce
     * @return List<String> containing all Account names
     */
    public static List<String> getAllAccountNames() {
        List<String> accountNames = new List<String>();
        
        // Query all Accounts (consider using a LIMIT in production)
        List<Account> accounts = [SELECT Id , Name FROM Account ORDER BY Name];
        
        // Extract names and add to list
        for (Account acc : accounts) {
            accountNames.add(acc.Name);
        }
        
        return accountNames;
    }
    
    /**
     * Alternative method that returns Account names in batches with pagination
     * @param offset The starting row (for pagination)
     * @param batchSize The number of records to return
     * @return List<String> containing Account names in the specified batch
     */
    public static List<String> getAccountNamesBatch(Integer offset, Integer batchSize) {
        List<String> accountNames = new List<String>();
        
        // Query Accounts with pagination
        List<Account> accounts = [SELECT Name FROM Account 
                                 ORDER BY Name 
                                 LIMIT :batchSize 
                                 OFFSET :offset];
        
        for (Account acc : accounts) {
            accountNames.add(acc.Name);
        }
        
        return accountNames;
    }
    
    /**
     * Method to get the total count of Accounts
     * @return Integer count of all Accounts
     */
    public static Integer getTotalAccountCount() {
        return [SELECT COUNT() FROM Account];
    }
}