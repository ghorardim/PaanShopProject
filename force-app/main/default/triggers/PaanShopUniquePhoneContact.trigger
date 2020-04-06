trigger PaanShopUniquePhoneContact on PaanShopContact__c (before insert) {
   set<String> newPhoneNumbers = new set<String>();
  for(PaanShopContact__c obj : Trigger.new)
  {
      if(obj.PhoneNumber__c!=null)
      newPhoneNumbers.add(obj.PhoneNumber__c);
  }

  //Query all existing records
 Map<String,PaanShopContact__c> mapPhoneNo = new Map<String,PaanShopContact__c>();
 for(PaanShopContact__c obj  : [select id,PhoneNumber__c, Name from PaanShopContact__c where PhoneNumber__c in : newPhoneNumbers])
 { 
  if(!mapPhoneNo.containskey(obj.PhoneNumber__c))
      mapPhoneNo.put(obj.PhoneNumber__c,obj);
 }

 //loop through the trigger.new
for(PaanShopContact__c obj : Trigger.new)
{
   if(obj.PhoneNumber__c!=null && mapPhoneNo.containskey(obj.PhoneNumber__c))
   {
    obj.addError('This Mobile no. is already used in ' + mapPhoneNo.get(obj.PhoneNumber__c).Name);
   }
}

}