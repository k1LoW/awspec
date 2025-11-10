# Changelog

## [v1.35.0](https://github.com/k1LoW/awspec/compare/v1.34.0...v1.35.0) - 2025-11-10
- Improve backup plan rules output by @endemics in https://github.com/k1LoW/awspec/pull/611
- Add missing details for IAM roles and policies by @endemics in https://github.com/k1LoW/awspec/pull/609
- chore: remove ERB trim fix warnings by @endemics in https://github.com/k1LoW/awspec/pull/610
- chore: setup tagpr labels by @k1LoW in https://github.com/k1LoW/awspec/pull/608

## [v1.34.0](https://github.com/k1LoW/awspec/compare/v1.33.0...v1.34.0) - 2025-10-18
- Add support for aws backup rules (under backup plan) by @endemics in https://github.com/k1LoW/awspec/pull/605
- feat: setup tagpr by @k1LoW in https://github.com/k1LoW/awspec/pull/606

## [v1.33.0](https://github.com/k1LoW/awspec/compare/v1.32.0...v1.33.0) - 2025-08-10
- Add wafv2_web_acl resource by @alpineriveredge in https://github.com/k1LoW/awspec/pull/600
- Add type backup (new PR - no copyright headers) by @endemics in https://github.com/k1LoW/awspec/pull/601
- Add tag support for DB and Global clusters by @alpineriveredge in https://github.com/k1LoW/awspec/pull/603
- Make transfer_server searchable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/604

## [v1.32.0](https://github.com/k1LoW/awspec/compare/v1.31.0...v1.32.0) - 2025-01-28
- Add codepipeline resource by @alpineriveredge in https://github.com/k1LoW/awspec/pull/592
- Add wafv2_ip_set resource by @alpineriveredge in https://github.com/k1LoW/awspec/pull/597
- Fix find vpc_endpoint by Name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/598

## [v1.31.0](https://github.com/k1LoW/awspec/compare/v1.30.0...v1.31.0) - 2025-01-22
- Enhance codebuild resource by @alpineriveredge in https://github.com/k1LoW/awspec/pull/591
- fix: Drop support for Ruby 2.x by @k1LoW in https://github.com/k1LoW/awspec/pull/596
- Fix finding Gateway VPC Endpoints by id by @alexjfisher in https://github.com/k1LoW/awspec/pull/595

## [v1.30.0](https://github.com/k1LoW/awspec/compare/v1.29.3...v1.30.0) - 2024-04-16
- Make `transit_gateway` `have_attachment` work with names by @alexjfisher in https://github.com/k1LoW/awspec/pull/586
- Add managed_prefix_list resource by @alpineriveredge in https://github.com/k1LoW/awspec/pull/587

## [v1.29.3](https://github.com/k1LoW/awspec/compare/v1.29.2...v1.29.3) - 2024-01-04
- Added pagination support to ssm_parameter by @anjo-swe in https://github.com/k1LoW/awspec/pull/583

## [v1.29.2](https://github.com/k1LoW/awspec/compare/v1.29.1...v1.29.2) - 2023-04-08
- Add support for a custom aws endpoint by @sverch in https://github.com/k1LoW/awspec/pull/580

## [v1.29.1](https://github.com/k1LoW/awspec/compare/v1.29.0...v1.29.1) - 2023-03-21
- Make network_interface searchable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/582

## [v1.29.0](https://github.com/k1LoW/awspec/compare/v1.28.2...v1.29.0) - 2023-03-18
- Make 'nat_gateway have_eip' searchable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/576
- Fix ECR Repository document by @alpineriveredge in https://github.com/k1LoW/awspec/pull/577
- Add policy_document to IAM Policy by @alpineriveredge in https://github.com/k1LoW/awspec/pull/578
- Fix ALB & NLB have_subnet by @alpineriveredge in https://github.com/k1LoW/awspec/pull/579
- [BREAKING] Drop 2.1 2.2 from supported Ruby versions / Add 3.2 by @k1LoW in https://github.com/k1LoW/awspec/pull/581
- Update doc for ecs_service for using non-default cluster by @jedipunkz in https://github.com/k1LoW/awspec/pull/508

## [v1.28.2](https://github.com/k1LoW/awspec/compare/v1.28.1...v1.28.2) - 2022-10-24
- Add vpc_endpoints attributes by @alpineriveredge in https://github.com/k1LoW/awspec/pull/571
- Add Elastic IP attributes by @alpineriveredge in https://github.com/k1LoW/awspec/pull/572
- s3_bucket - fixed documentation for prefix in have_lifecycle_rule by @anjo-swe in https://github.com/k1LoW/awspec/pull/573
- Make 'vpc_endponts have_subnet' testable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/574
- Make vpn_gateway searchable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/575

## [v1.28.1](https://github.com/k1LoW/awspec/compare/v1.28.0...v1.28.1) - 2022-08-29
- Fix vpc_endpoints document by @alpineriveredge in https://github.com/k1LoW/awspec/pull/569
- Allow Tags of CloudFormation Stack by @alpineriveredge in https://github.com/k1LoW/awspec/pull/570

## [v1.28.0](https://github.com/k1LoW/awspec/compare/v1.27.1...v1.28.0) - 2022-08-16
- Add RDS DB Cluster & Global Cluster by @alpineriveredge in https://github.com/k1LoW/awspec/pull/566

## [v1.27.1](https://github.com/k1LoW/awspec/compare/v1.27.0...v1.27.1) - 2022-07-18
- Make eip searchable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/565

## [v1.27.0](https://github.com/k1LoW/awspec/compare/v1.26.0...v1.27.0) - 2022-07-03
- Add RDS Proxy by @alpineriveredge in https://github.com/k1LoW/awspec/pull/564

## [v1.26.0](https://github.com/k1LoW/awspec/compare/v1.25.2...v1.26.0) - 2022-06-06
- Use parallel.gem by @k1LoW in https://github.com/k1LoW/awspec/pull/557
- Add transfer_server type by @andoniaf in https://github.com/k1LoW/awspec/pull/558
- Make vpc_endpoint searchable by name by @alpineriveredge in https://github.com/k1LoW/awspec/pull/561
- require octorelease when not CI by @k1LoW in https://github.com/k1LoW/awspec/pull/562

## [v1.25.2](https://github.com/k1LoW/awspec/compare/v1.25.1...v1.25.2) - 2022-01-25
- Support Ruby 3.0.x by @k1LoW in https://github.com/k1LoW/awspec/pull/554
- Support Ruby 3.1.x by @k1LoW in https://github.com/k1LoW/awspec/pull/555
- Update rubocop by @k1LoW in https://github.com/k1LoW/awspec/pull/556

## [v1.25.1](https://github.com/k1LoW/awspec/compare/v1.25.0...v1.25.1) - 2021-10-08
- Fix: undefined method `by_cidr' by @k1LoW in https://github.com/k1LoW/awspec/pull/550

## [v1.25.0](https://github.com/k1LoW/awspec/compare/v1.24.4...v1.25.0) - 2021-09-04
- Bugfix/issue 264 by @glasswalk3r in https://github.com/k1LoW/awspec/pull/538
- Added missing SNS specs by @glasswalk3r in https://github.com/k1LoW/awspec/pull/547
- Bugfix/issue 527 by @glasswalk3r in https://github.com/k1LoW/awspec/pull/548

## [v1.24.4](https://github.com/k1LoW/awspec/compare/v1.24.3...v1.24.4) - 2021-08-09
- Use GitHub Actions by @k1LoW in https://github.com/k1LoW/awspec/pull/541
- Update rubocop by @k1LoW in https://github.com/k1LoW/awspec/pull/542
- refactor: faster EC2 instance search by @glasswalk3r in https://github.com/k1LoW/awspec/pull/535
- Feature/issue 407 by @glasswalk3r in https://github.com/k1LoW/awspec/pull/543
- Feature/metric filter pattern support by @JinhuaK in https://github.com/k1LoW/awspec/pull/544

## [v1.24.3](https://github.com/k1LoW/awspec/compare/v1.24.2...v1.24.3) - 2021-07-12
- Added elasticache spec generator by @inokappa in https://github.com/k1LoW/awspec/pull/540

## [v1.24.2](https://github.com/k1LoW/awspec/compare/v1.24.1...v1.24.2) - 2021-07-04
- fix: properly handling EC2 errors by @glasswalk3r in https://github.com/k1LoW/awspec/pull/534
- Bugfix/issue 325 by @glasswalk3r in https://github.com/k1LoW/awspec/pull/537

## [v1.24.1](https://github.com/k1LoW/awspec/compare/v1.24.0...v1.24.1) - 2021-05-08
- Fixed a bug when a bucket was placed in us-east-1 by @soruma in https://github.com/k1LoW/awspec/pull/533
