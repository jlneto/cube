#!/usr/bin/env node

import cdk = require('@aws-cdk/core');
import { CdkSampleInitStack } from '../lib/cdk-sample-init-stack';
import { CubeFargateStack } from '../lib/cube-fargate-stack';

const app = new cdk.App();
const initStack = new CdkSampleInitStack(app, 'CdkSampleInitStack');

// for service :cube
new CubeFargateStack(app, 'CubeFargateStack', {
    vpc: initStack.vpc,
    cluster: initStack.cluster
});


app.synth();
