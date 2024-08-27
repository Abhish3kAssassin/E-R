// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EducationStakingPool {
    using SafeMath for uint256;

    IERC20 public stakingToken;    
    uint256 public rewardRate = 10; // Represents 0.1 reward rate when divided by 100

    struct StakeInfo {
        uint256 amountStaked;
        uint256 rewardEarned;
        uint256 lastStakedTime;
    }

    mapping(address => StakeInfo) public stakes;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardsClaimed(address indexed user, uint256 amount);

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Cannot stake 0");

        // Update the user's rewards before staking
        updateRewards(msg.sender);

        stakes[msg.sender].amountStaked = stakes[msg.sender].amountStaked.add(_amount);
        stakes[msg.sender].lastStakedTime = block.timestamp;

        stakingToken.transferFrom(msg.sender, address(this), _amount);
        emit Staked(msg.sender, _amount);
    }

    function unstake(uint256 _amount) external {
        require(stakes[msg.sender].amountStaked >= _amount, "Insufficient staked amount");

        // Update the user's rewards before unstaking
        updateRewards(msg.sender);

        stakes[msg.sender].amountStaked = stakes[msg.sender].amountStaked.sub(_amount);
        stakingToken.transfer(msg.sender, _amount);
        emit Unstaked(msg.sender, _amount);
    }

    function claimRewards() external {
        updateRewards(msg.sender);
        uint256 rewards = stakes[msg.sender].rewardEarned;

        require(rewards > 0, "No rewards to claim");
        stakes[msg.sender].rewardEarned = 0;

        stakingToken.transfer(msg.sender, rewards);
        emit RewardsClaimed(msg.sender, rewards);
    }

    function updateRewards(address _user) internal {
        StakeInfo storage userStake = stakes[_user];
        
        uint256 duration = block.timestamp.sub(userStake.lastStakedTime);
        userStake.rewardEarned = userStake.rewardEarned.add(userStake.amountStaked.mul(rewardRate).mul(duration).div(1 days).div(100));
        userStake.lastStakedTime = block.timestamp;
    }

    function getStakeInfo(address _user) external view returns (uint256 amountStaked, uint256 rewardEarned) {
        StakeInfo storage userStake = stakes[_user];
        return (userStake.amountStaked, userStake.rewardEarned);
    }
}
