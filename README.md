# Civic-Uniswap v4 Hook

## Introduction
This repository contains an [Civic Pass](www.civic.com) hook for Uniswap v4,
aimed at enabling KYC/AML processes within the liquidity pools of Uniswap v4.

Pools that include this hook ensure that only users with a verified Civic Pass
can participate in trading.

## Civic Pass
Civic Pass is a solution engineered for Identity and Access Management (IAM)
within distributed ledger technologies.

It facilitates the verification, issuance, and lifecycle management of a
user's identity in a seamless and secure manner.

Civic performs various verification checks including identity documents,
location, and humanness on behalf of dApps or DeFi platforms,
issuing a non-transferable token - the Civic Pass.

This pass can be implemented by dApps and DeFi platforms to vet their users
while maintaining user privacy.

## Uniswap v4
Uniswap v4 is the latest iteration of the Uniswap Protocol,
bringing forth novel features like "hooks" which are contracts
that run at specific points during a pool action's lifecycle.

These hooks allow for a more customizable trading experience,
enabling functionalities like the one achieved in this integration.
Through hooks, developers can craft custom automated market maker (AMM) features,
enhancing the overall trading process on the platform.

## Integration Mechanism
1. **Hook Creation**:
  - A custom hook is created within Uniswap v4 that interfaces with the
  [Gateway Protocol](https://github.com/identity-com/on-chain-identity-gateway) on which Civic Pass is based.
  - When creating the hook, the pass type (identity document verification, uniqueness, etc.) is specified.
  - The hook is triggered whenever a user attempts a trade on Uniswap v4.
2. **Civic Pass Verification**:
  - Upon triggering, the hook communicates with the Gateway Protocol
to check the user's pass status.
  - Trading is allowed only if the user possesses a valid and active Civic Pass.
3. **Trade Execution**:
  - Once the Civic Pass verification is successful, the trade is executed within the Uniswap v4 environment.
  - All trades are recorded on-chain ensuring transparency and compliance.

