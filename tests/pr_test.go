// Tests in this file are run in the PR pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

// Use existing resource group
const resourceGroup = "geretain-test-data-engine"
const completeExampleTerraformDir = "examples/complete"

const regionSelectionPath = "../common-dev-assets/common-go-assets/icd-region-prefs.yaml"

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()
	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:            t,
		TerraformDir:       completeExampleTerraformDir,
		Prefix:             "data-engine-complete",
		ResourceGroup:      resourceGroup,
		BestRegionYAMLPath: regionSelectionPath,
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeExample(t *testing.T) {
	t.Parallel()

	// TODO: Remove this line after the first merge to primary branch is complete to enable upgrade test
	t.Skip("Skipping upgrade test until initial code is in primary branch")

	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:            t,
		TerraformDir:       completeExampleTerraformDir,
		Prefix:             "data-engine-upg",
		ResourceGroup:      resourceGroup,
		BestRegionYAMLPath: regionSelectionPath,
	})

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
