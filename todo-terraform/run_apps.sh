#!/bin/bash
./start
sleep 1800
aws eks update-kubeconfig --region ap-south-1 --name protfolio-yuval-eks-cluster