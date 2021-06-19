//토큰 판매를 위한 계약 작성
pragma solidity ^0.4.24;
import './DNextToken.sol';
import './DNextTokenWhitelist.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

contract DNextTokenSale{
    using SafeMath for uint256;
    uint public constant EMMAS_PER_WEI = 10000000; // 1wei 당 교환해줄 emma의 비율
    uint public constant HARD_CAP = 500000000000000; //최대판매수량
    DNextToken public token; //우리가 만든 토큰 확인
    DNextTokenWhitelist public whitelist;
    uint public emmasRaised; //판매된 전체 emma수
    bool private closed; // 종료여부
    

    function DNextTokenSale (DNextToken _token, DNextTokenWhitelist _whitelist) public {
        require(_token != address(0));
        token = _token;
        whitelist = _whitelist;
    } // _token : 배포된 계약계정의 주소 , _whitelist : DNextTokenWhitelist: DNextTokenWhitelist의 계약 계정의 주소

    // 실제판매
    // 이름 없는 함수 = fallback , 이 함수는 어떤 파라미터도 가질 수없고 어떤 값도 반환 할 수 없음
    // payable: 토큰 판매를 위한 함수이기에 필수적으로 설정되어야하는 사항
    function() external payable{
        require(!closed); // 토큰 판매가 종료 되지 않았는지 확인
        require(msg.value != 0); // 이더 금액을 명시했는지 확인
        require(whitelist.isRegistered(msg.sender)); // 참여자의 계정이 등록되었는지

        uint emmasToTransfer = msg.value.mul(EMMAS_PER_WEI); //판매의 댓가로 전송해줘야 할 emma 의 수
        uint weisToRefund = 0;
        if(emmasRaised + emmasToTransfer > HARD_CAP){
            emmasToTransfer = HARD_CAP - emmasRaised;
            weisToRefund = msg.value - emmasToTransfer.div(EMMAS_PER_WEI);
            closed = true;
        }
        emmasRaised = emmasRaised.add(emmasToTransfer);
        if(weisToRefund > 0){
            msg.sender.transfer(weisToRefund);
        }
        token.transfer(msg.sender, emmasToTransfer);
    }
}