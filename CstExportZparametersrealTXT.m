% Copyright (C) 2018  Symeon Symeonidis, Stefanos Tsantilas, Stelios Mitilineos
% simos421@gmail.com, steftsantilas@gmail.com, smitil@gmail.com
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

function CstExportZparametersrealTXT(mws, exportpathr)

SelectTreeItem = invoke(mws,'SelectTreeItem','1D Results\Z Matrix\Z1,1');
plot1d=mws.invoke('Plot1d');
ASCIIExport = invoke(mws,'ASCIIExport');
plot1d.invoke('PlotView','real');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',exportpathr);
invoke(ASCIIExport,'Execute');

end

