/**
 * 
 */
function run(){
    document.getElementById('myTable').onclick = function(event){
        event = event || window.event; //for IE8 backward compatibility
        var target = event.target || event.srcElement; //for IE8 backward compatibility
        while (target && target.nodeName != 'TR') {
            target = target.parentElement;
        }
        var cells = target.cells; //cells collection
        //var cells = target.getElementsByTagName('td'); //alternative
        if (!cells.length || target.parentNode.nodeName == 'THEAD') { // if clicked row is within thead
            return;
        }
        var f1 = document.getElementById('firstname');
        var f2 = document.getElementById('lastname');
        var f3 = document.getElementById('age');
        var f4 = document.getElementById('total');
        var f5 = document.getElementById('discount');
        var f6 = document.getElementById('diff');
        f1.value = cells[0].innerHTML;
        f2.value = cells[1].innerHTML;
        f3.value = cells[2].innerHTML;
        f4.value = cells[3].innerHTML;
        f5.value = cells[4].innerHTML;
        f6.value = cells[5].innerHTML;
    }
}