document.getElementById('mySelect').addEventListener('change', function() {
    const selectedCoach = this.value;
    const container = document.getElementById('radio-buttons-container');
    
    // Clear previous radio buttons
    container.innerHTML = '';

    if (selectedCoach) {
        const options = ['Option 1', 'Option 2', 'Option 3']; // Replace with relevant options

        options.forEach(option => {
            const label = document.createElement('label');
            const radioButton = document.createElement('input');

            radioButton.type = 'radio';
            radioButton.name = 'options';
            radioButton.value = option;

            label.appendChild(radioButton);
            label.appendChild(document.createTextNode(option));
            container.appendChild(label);
            container.appendChild(document.createElement('br')); // Line break for each radio button
        });
    }
});