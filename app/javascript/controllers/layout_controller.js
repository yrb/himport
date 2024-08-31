import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        menuOpen: {type: Boolean, default: false},
    }
    static targets = ["backdrop", "menu", "button", "dialog"]

    backdropEnter = "opacity-100";
    backdropLeave = "opacity-0";

    menuEnter = "translate-x-0";
    menuLeave = "-translate-x-full";

    buttonEnter = "opacity-100";
    buttonLeave = "opacity-0";

    openMenu() {
        console.log("openMenu");
        this.menuOpenValue = true;
    }

    closeMenu() {
        this.menuOpenValue = false;
    }

    menuOpenValueChanged(value) {
        value ? this.showMenu() : this.hideMenu();
    }

    showMenu() {
        this.dialogTarget.classList.remove("invisible");
        this.backdropTarget.classList.remove(this.backdropLeave);
        this.menuTarget.classList.remove(this.menuLeave);
        this.buttonTarget.classList.remove(this.buttonLeave);
        this.backdropTarget.classList.add(this.backdropEnter);
        this.menuTarget.classList.add(this.menuEnter);
        this.buttonTarget.classList.add( this.buttonEnter);
    }

    hideMenu() {
        this.backdropTarget.classList.add(this.backdropLeave);
        this.menuTarget.classList.add(this.menuLeave);
        this.buttonTarget.classList.add(this.buttonLeave);
        this.backdropTarget.classList.remove(this.backdropEnter);
        this.menuTarget.classList.remove(this.menuEnter);
        this.buttonTarget.classList.remove( this.buttonEnter);
        setTimeout(() => this.dialogTarget.classList.add("invisible"), 350);
    }

    connect() {
        this.dialogTarget.classList.add("invisible");
    }
}
