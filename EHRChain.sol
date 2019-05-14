pragma solidity >=0.4.22 <0.6.0;

contract ehrtest{
    
    //address userAddress;
    // model a userRecord 
    
    struct UserStructRecord {
        string name;
        uint userAge;
        string infos;
        address userAddress;
        uint index;
        mapping (address => uint) myReaders;
        mapping (address => uint) icanRead;
    }
    

    // get tract of all the UserRecord
   // we can do a search for a specific ethereum address
   //we can also fid a specifique instructor name and infos
    mapping(address => UserStructRecord) allUserStructRecord;
    
    //Dynamic array of addresses to track the keys we insert.
    address[] private userIndex;
   // address doctorAddress;
    
    //  define event to keep tract of state change within the contract
    //Event emitters that report all state changes
    event LogNewUser   (address indexed userAddress, uint index, string name, uint userAge, string infos);
    event LogUpdateUser(address indexed userAddress, uint index, string  name, uint userAge, string infos);
    
    //event accessGrante(address indexed doctorAddress);

    
   /* // check is user with address exist
    function isUser(address userAddress) public view returns(bool isIndeed) 
    {
        if(userIndex.length == 0) return false;
    */
    
    // insert values in the struct record 
    function insertUserRecord(address userAddress, address DoctorAddress, string memory name, uint userAge, string memory infos) public returns(uint index) 
    {
        require(didIGaveRights(DoctorAddress));
        //require(isUser(userAddress)); 
        allUserStructRecord[userAddress].name = name;
        allUserStructRecord[userAddress].userAge = userAge;
        allUserStructRecord[userAddress].infos = infos;
        allUserStructRecord[userAddress].index = userIndex.push(userAddress)-1;
    
        emit LogNewUser(userAddress, allUserStructRecord[userAddress].index, name, userAge, infos);
        
        return userIndex.length-1; // return the index where the record is stored
       
        
    }
    // get  user record information of the given address
    function getUserRecord(address userAddress, address DoctorAddress)  public view returns(string memory name, uint userAge, string memory infos, uint index) 
    {
        require(didIGaveRights(DoctorAddress));
        //require(didIGaveRights(userAddress));
        //check the existence of keys before we permit any changes, and before we return an instance/record
         //require(!isUser(userAddress));
        return(
        allUserStructRecord[userAddress].name,
        allUserStructRecord[userAddress].userAge,
        allUserStructRecord[userAddress].infos,
        allUserStructRecord[userAddress].index);
    }
    
    // update UserRecord infos field
    
    function updateUserInfos(address userAddress, address DoctorAddress, string memory infos)  public
    {
        require(didIGaveRights(DoctorAddress));
        //require(!isUser(userAddress)); 
        //only the doctor with granted permission can update
        allUserStructRecord[userAddress].infos = infos;
        emit LogUpdateUser(userAddress, allUserStructRecord[userAddress].index, allUserStructRecord[userAddress].name, allUserStructRecord[userAddress].userAge, infos);
        
    }
    
    // update UserRecord age field
     function updateUserAge(address userAddress,address DoctorAddress, uint userAge)  public returns(bool success)
    {
        require(didIGaveRights(DoctorAddress));
        //require(!isUser(userAddress)); 
        //only the doctor with granted permission can update
        allUserStructRecord[userAddress].userAge = userAge;
        emit LogUpdateUser(userAddress, allUserStructRecord[userAddress].index, allUserStructRecord[userAddress].name, userAge, allUserStructRecord[userAddress].infos);
        return true;
    }
    
    //get the total number of record stored
    function getUserCount() public view returns(uint count)
    {
        return userIndex.length;
    }
    
    // next we want to register an entity to the system it could be a doctor or a patient
    
     //function entityRegister(string memory user)payable public{}
   
    // check the registration of that entity
    
    // give access to a  doctor with a given address
    
      function grantAccess(address doctor) public {
       // require(isUser(userAddress));
        allUserStructRecord[msg.sender].myReaders[doctor] = 1;
        allUserStructRecord[doctor].icanRead[msg.sender] = 1;
        //emit accessGrante(doctor);
    }
    
    //revoke access to a particular user
      function revokeAccess(address user) public{
        allUserStructRecord[msg.sender].myReaders[user] = 2;
        allUserStructRecord[user].icanRead[msg.sender] = 2;
    }
    
    // check if a user have the right to read the data 
      function didIGaveRights(address doctor) public view returns(bool){
         
        // require(isUser(userAddress));
        if( allUserStructRecord[msg.sender].myReaders[doctor] == 1){
            return true;
        }else {
            return false;
        }
    }
    
      function doIHaveRights(address x) public view returns(bool){
        if(allUserStructRecord[x].icanRead[msg.sender] == 1){
            return true;
        }else {
            return false;
        }
    }
    
   // function to get a data store at index i in 
    function getDataAtIndex(uint index1,address  userAddress) public view  returns(string memory name, uint userAge, string memory infos, uint index) 
     {
     
        for (uint i=0; i<userIndex.length; i++) {
           if (allUserStructRecord[userAddress].index == index1) {
              return(
        allUserStructRecord[userAddress].name,
        allUserStructRecord[userAddress].userAge,
        allUserStructRecord[userAddress].infos,
        allUserStructRecord[userAddress].index);
           }
         }
    }
    
   
    
    
    
    
    
    
}