
function add_to_cart(pid, pname, pprice)
{
    let cart = localStorage.getItem("cart");
    if (cart == null)
    {
        //no card at yet
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: pprice}
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
      //  console.log("product is added first time");
        showToast("Item Is Added To Cart");
    } else
    {
        //card is alerady present
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid)
        if (oldProduct)
        {
            //we have increase queanitity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {

                if (item.productId == oldProduct.productId)
                {
                    item.productQuantity = oldProduct.productQuantity;
                }

            })
            localStorage.setItem("cart", JSON.stringify(pcart));
            //console.log("product Quantity is increaase");
             showToast(oldProduct.productName+"Quantity Is Increased , Quantity="+oldProduct.productQuantity);
        } else
        {
            //we have add the product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: pprice}
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
         //   console.log("product is added");
             showToast("Product Is Added To Cart");
        }


    }
    updateCart();
}
//upadate card 
function updateCart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0)
    {
        console.log("card is empty");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any items</h3>");
        $(".checkout-btn").attr("disabled",true);
    } else
    {
        //there is somthin in card to show
        console.log(cart);
        $(".cart-items").html(`( ${cart.length})`);
        let table = `
        <table class='table'>
        <thead class='thread-light'>
            <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>action</th>
        
            </tr>
        </thead>






`;
        let totalPrice = 0;
        cart.map((item) => {

            table += `
                <tr>
                <td>${item.productName}</td>
                <td>${item.productPrice}</td>
                <td>${item.productQuantity}</td>
                <td>${item.productQuantity * item.productPrice}</td>
                <td><button onclick="deleteItemFromCart(${item.productId})" class="btn btn-danger btn-sm" >Remove</button></d>

                </tr>
          
`
            totalPrice += item.productPrice * item.productQuantity;


        })


        table = table + `
        <tr><td colspan='5' class="text-right font-weight-bold m-5">Total Price:${totalPrice}</td></tr>
        </table>`
        $(".cart-body").html(table);
        $(".checkout-btn").attr("disabled",false);
    }

}
//delete item
function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem("cart"));
    let newcart = cart.filter((item) => item.productId != pid);
    localStorage.setItem("cart", JSON.stringify(newcart));
    updateCart();
    showToast("Item Is Removed From Cart");


}


$(document).ready(function () {
    updateCart();
})

function showToast(content)
{
    $('#toast').addClass("display");
    $('#toast').html(content);

    setTimeout(() => {
        $('#toast').removeClass("display");
    }, 3000)
}
function goToCheckout()
{
    window.location="checkout.jsp";
}