# PAYBACK Coding Challenge

## Solution approach

To integrate acceptance criteria defined in coding challenge I have made few assumptions:
* implementation should respect Clean Architecture and SOLID principles
* base code should be third party free as much as possible (only UIColor and Reachability component is used)
* for business rules there should be defined domain model with Domain Driven Design approach
* all business logic should be unit tested

## Debug

There are few components that allows to change behaviour of app and transactions functionality:

* to recognise device offline functionality there are 2 implementations of `ReachabilityService`. For simulation purposes there is `SimulatorReachabilityService` which allows to set unreachable timeout periods and duration. For production use there is `DeviceReachabilityService` implentation which is using third party component to recognise reachability. All depencencies can be changed in `ApplicationAssembly` class.

* transactions feature contains `TransactionItemRepository` abstraction which is used to define different strategies of received data. Currently all requests are mocked and content of JSON file is returned. In addition there is functionality to set different behaviour for error condition or delay. It's possible to change that in `TransactionsAssembly` class by update properties of `JSONFileBasedTransactionItemRepository`. For network calls there exists only empty repository integration in `NetworkBasedTransactionItemRepository` class which should be implenented when service endpoints will be provided by backend team.

## Unfinished functionalities

* missing implementation for `Theme` and support all views with custom styles, only few of them are supporting custom images or colors (ususally marked as TODO: in code)
* for diffrent feature integrations there is an use case with sum of all transactions (for future proposal of having Feed feature with transactions component), however it's not integrated.

## Third Party components

* Reachability: https://github.com/ashleymills/Reachability.swift
* UIColor+hex: https://github.com/thii/SwiftHEXColors
