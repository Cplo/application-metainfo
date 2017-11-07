#!/usr/bin/env bash

print_merge_params() {
    echo "=================================================="
    echo "gitlabActionType : ${gitlabActionType}"
    echo "gitlabBranch : ${gitlabBranch}"
    echo "gitlabMergeRequestId : ${gitlabMergeRequestId}"
    echo "gitlabMergeRequestIid : ${gitlabMergeRequestIid}"
    echo "gitlabMergeRequestLastCommit : ${gitlabMergeRequestLastCommit}"
    echo "gitlabMergeRequestTitle : ${gitlabMergeRequestTitle}"
    echo "gitlabSourceBranch : ${gitlabSourceBranch}"
    echo "gitlabSourceNamespace : ${gitlabSourceNamespace}"
    echo "gitlabSourceRepoHomepage : ${gitlabSourceRepoHomepage}"
    echo "gitlabSourceRepoHttpUrl : ${gitlabSourceRepoHttpUrl}"
    echo "gitlabSourceRepoName : ${gitlabSourceRepoName}"
    echo "gitlabSourceRepoSshUrl : ${gitlabSourceRepoSshUrl}"
    echo "gitlabSourceRepoURL : ${gitlabSourceRepoURL}"
    echo "gitlabTargetBranch : ${gitlabTargetBranch}"
    echo "gitlabTargetNamespace : ${gitlabTargetNamespace}"
    echo "gitlabTargetRepoHttpUrl : ${gitlabTargetRepoHttpUrl}"
    echo "gitlabTargetRepoName : ${gitlabTargetRepoName}"
    echo "gitlabTargetRepoSshUrl : ${gitlabTargetRepoSshUrl}"
    echo "gitlabUserEmail : ${gitlabUserEmail}"
    echo "gitlabUserName : ${gitlabUserName}"
    echo "=========================================================="
}
