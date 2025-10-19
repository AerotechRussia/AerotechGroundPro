function Component()
{

}

Component.prototype.createOperations = function()
{
    try {
        component.createOperations();
    } catch (e) {
        console.log(e);
    }

    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", "@TargetDir@/bin/agp.exe", "@StartMenuDir@/AGP.lnk");
        component.addOperation("CreateShortcut", "@TargetDir@/bin/agp.exe", "@DesktopDir@/AGP.lnk");
    }
}
