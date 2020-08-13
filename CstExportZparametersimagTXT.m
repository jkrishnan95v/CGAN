function CstExportZparametersimagTXT(mws, exportpathi)

SelectTreeItem = invoke(mws,'SelectTreeItem','1D Results\Z Matrix\Z1,1');
plot1d=mws.invoke('Plot1d');
ASCIIExport = invoke(mws,'ASCIIExport');
plot1d.invoke('PlotView','imaginary');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',exportpathi);
invoke(ASCIIExport,'Execute');

end

