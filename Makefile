.PHONY: deploy-pipeline
deploy-pipeline: 
	oc new-project workspace-demo || true
	oc apply -f deploy/pipeline-sa-role.yaml -n workspace-demo
	oc apply -f deploy/ike-task.yaml -n workspace-demo
	
	## additional tasks
	oc apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/github-set-status/0.1/github-set-status.yaml  -n workspace-demo
	oc apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/github-add-comment/0.1/github-add-comment.yaml  -n workspace-demo
	oc apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/buildah/0.1/buildah.yaml  -n workspace-demo
		
	oc apply -f deploy/tekton-demo-lab-pvc.yaml -n workspace-demo
	oc apply -f deploy/tekton-demo-lab-repo.yaml -n workspace-demo
	oc apply -f deploy/tekton-demo-lab-image.yaml -n workspace-demo
	oc apply -f deploy/tekton-demo-lab-pipeline.yaml -n workspace-demo

	# github 
	oc apply -f deploy/tekton-demo-lab-gh-pr-binding.yaml -n workspace-demo
	oc apply -f deploy/tekton-demo-lab-template.yaml -n workspace-demo
	oc apply -f deploy/tekton-demo-lab-listener.yaml -n workspace-demo

	oc expose svc el-tekton-demo || true

	# done


undeploy-pipeline: 
	oc delete -f deploy/pipeline-sa-role.yaml -n workspace-demo || true
	oc delete -f deploy/ike-task.yaml -n workspace-demo || true
	
	## additional tasks
	oc delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/github-set-status/0.1/github-set-status.yaml  -n workspace-demo || true
	oc delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/github-add-comment/0.1/github-add-comment.yaml  -n workspace-demo || true
	oc delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/buildah/0.1/buildah.yaml -n workspace-demo || true
		
	oc delete -f deploy/tekton-demo-lab-pvc.yaml -n workspace-demo || true
	oc delete -f deploy/tekton-demo-lab-repo.yaml -n workspace-demo || true
	oc delete -f deploy/tekton-demo-lab-image.yaml -n workspace-demo || true
	oc delete -f deploy/tekton-demo-lab-pipeline.yaml -n workspace-demo || true

	# github 
	oc delete -f deploy/tekton-demo-lab-gh-pr-binding.yaml -n workspace-demo || true
	oc delete -f deploy/tekton-demo-lab-template.yaml -n workspace-demo || true
	oc delete -f deploy/tekton-demo-lab-listener.yaml -n workspace-demo || true

	# done
