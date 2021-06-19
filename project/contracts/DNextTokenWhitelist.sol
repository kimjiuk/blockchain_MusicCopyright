// 사전 등록을 위한 계약 작성
pragma solidity ^0.4.24;
contract DNextTokenWhitelist {
    address owner;
    function DNextTokenWhitelist() public{
        owner = msg.sender;
    }
    mapping(bytes32 => bool) whitelist;//whitelist가 저장된 상태변수 설정.
    //mapping 자료형은 키, 값 형태로 구성된 자료의 집합.
    // 32바이트 데이터를 키로 가지고 bool자료형의 데이터를 값으로 가진다.
    // 이더리움 주소의 해시값에 대해 주소가 등록되어 있는지 확인하기 위함, 참여자들의 프라이버시도 보호해줌.

    function register() external {
        whitelist[keccak256(msg.sender)] = true;
    }// msg.sender의 해쉬값을 keccak256함수를 통해 구한뒤, whitelist의 변수의 값을 true로 만들어줌
    // 계약계정 내부에 있는 저장소에 해당하는 상태 변수에 영속적으로 저장
    // 참여자의 주소값 그 자체가 저장되는 것이 아니고 해시값만이 저장되어 있어서 참여자의 프라이버시를 보장.
    function unregister() external{
        whitelist[keccak256(msg.sender)] = false;
    }
    function isRegistered(address anAddress) public view returns (bool registered){
        return whitelist[keccak256(anAddress)];
    } //view 키워드는 블록체인의 상태를 변경시키지 않음을 의미함.
    
}