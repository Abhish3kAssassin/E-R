# Education Staking Pool

## Overview

This Smart Contract allows users to stake ERC20 tokens and earn rewards while funding educational projects. The reward rate is set to 0.1 (or 10 basis points), rewarding users based on the amount and duration of their stakes.

## Features

- **Stake Tokens:** Users can stake their ERC20 tokens to contribute to educational projects.
- **Unstake Tokens:** Users can withdraw their staked tokens at any time, as long as they have sufficient balance.
- **Reward Mechanism:** Users earn rewards based on their staked amount and the duration of staking.
- **Claim Rewards:** Users can claim their accrued rewards anytime.

## Contract Functions

1. **constructor(IERC20 _stakingToken):** Initializes the contract with a specified ERC20 token for staking.
  
2. **stake(uint256 _amount):** Lets users stake a specified amount of tokens. Updates the reward before staking.

3. **unstake(uint256 _amount):** Unstakes a certain amount of tokens, after updating the user's rewards.

4. **claimRewards():** Claims the accumulated rewards for the user.

5. **updateRewards(address _user):** Updates the reward for a user based on the staking duration and amount.

6. **getStakeInfo(address _user):** Returns the staking information of a user, including the amount staked and rewards earned.

## Reward Rate Calculation

The reward rate is set to `10`, which corresponds to `0.1%` or `10 basis points`. The rewards are calculated as follows:
rewardEarned = (amountStaked * rewardRate * duration) / (1 day * 100)


## Usage

1. Deploy the `EducationStakingPool` contract with the desired ERC20 token address.
2. Users can call `stake(amount)` to stake tokens.
3. Users can call `unstake(amount)` to withdraw tokens.
4. Users can call `claimRewards()` to claim their reward tokens.
5. Call `getStakeInfo(userAddress)` to check staking details.

## Flowchart


graph TD;
    A[Start] --> B[User Stake Tokens];
    B --> C[Update Rewards];
    C --> D[Store Stake Info];
    D --> E[Emit Staked Event];
    E --> F{User Wants to Unstake?};
    F -- Yes --> G[Update Rewards];
    G --> H[Unstake Tokens];
    H --> I[Emit Unstaked Event];
    I --> J{User Wants to Claim Rewards?};
    F -- No --> J;
    J -- Yes --> K[Update Rewards];
    K --> L[Claim Rewards];
    L --> M[Emit Rewards Claimed Event];
    J -- No --> N[End];

# Conclusion
This contract allows users to contribute to educational projects while earning rewards for their staked tokens. It exemplifies how DeFi can support educational initiatives through cryptocurrency.


### Summary

The provided code forms a complete simple staking mechanism where users can stake their tokens, and the contract tracks the staked amounts to calculate and distribute rewards accordingly. The README gives informative details on using the contract, including the functions that it exposes as well as the reward calculation logic and a flowchart describing the flow of operations.

 
